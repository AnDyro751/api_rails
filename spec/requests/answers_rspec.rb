require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :request do

  before :each do
    @token = FactoryGirl.create(:token , expires_at: DateTime.now + 10.minutes)
    @poll = FactoryGirl.create(:poll_with_question,user:@token.user)
    @question = @poll.questions[0]
  end

  let(:valid_params){ { description: "Mi respuesta" , question_id: @question.id } }

  describe "POST /poll/:poll_id/answers" do
    before :each do
      post api_v1_poll_answers_path(@poll) , { params: { answer: valid_params ,token: @token.token } }
    end

    context "con usuario válido" do
      it { expect(response).to have_http_status(200) }

      it "cambia el contador +1" do
        expect{
          post api_v1_poll_answers_path(@poll) , { params: { answer: valid_params ,token: @token.token } }
        }.to change(Answer,:count).by(1)
      end

      it "responde con la respuesta creada" do
        json = JSON.parse(response.body)
        # puts "\n\n---#{json["description"]}"
        expect(valid_params[:description]).to eq(json["data"]["description"])
      end
    end

    context "con usuario invalido" do
      before :each do
        new_user = FactoryGirl.create(:dummy_user)
        @new_token = FactoryGirl.create(:token , user: new_user , expires_at: DateTime.now + 1.month)
        post api_v1_poll_answers_path(@poll) , { params: { answer: valid_params ,token: @new_token.token } }
      end
      it { expect(response).to have_http_status(401) }
      it "cambia el contador 0" do
        expect{
          post api_v1_poll_answers_path(@poll) , { params: { answer: valid_params ,token: @new_token.token } }
        }.to change(Answer,:count).by(0)
      end

      it "NO debe responde con la respuesta creada" do
        json = JSON.parse(response.body)
        # puts "\n\n---#{json["description"]}"
        expect(json["data"]["description"]).to eq(nil)
      end
    end
  end

  describe "PUT / PATCH /polls/:question_id/:id" do
    context "con usuario invalido" do
      before :each do
        new_user = FactoryGirl.create(:dummy_user)
        @new_token = FactoryGirl.create(:token , user: new_user , expires_at: DateTime.now + 1.month)
        @answer = FactoryGirl.create(:answer,question_id:@question.id)
        put api_v1_poll_answer_path(@poll,@answer) , { params: { answer: {description:"Elixir"} ,token: @new_token.token } }
      end
      it { expect(response).to have_http_status(401) }

      it "NOOO actualiza la encuesta adecuada" do
        json = JSON.parse(response.body)
        expect(json["data"]["description"]).to eq(nil)
      end
    end
    context "con usuario valido" do
      before :each do
        @answer = FactoryGirl.create(:answer,question_id:@question.id)
        put api_v1_poll_answer_path(@poll,@answer) , { params: { answer: {description:"Elixir"} ,token: @token.token } }
      end
      it { expect(response).to have_http_status(200) }

      it "actualiza la encuesta adecuada" do
        json = JSON.parse(response.body)
        expect(json["data"]["description"]).to eq("Elixir")
      end
    end
  end

  describe "DELETE /polls/:question_id/:id" do
    context "con usuario válido" do
      before :each do
        @answer = FactoryGirl.create(:answer,question_id:@question.id)
      end

      it "responde con un status 200" do
        delete api_v1_poll_answer_path(@poll,@answer) , { params: { token: @token.token } }
        expect(response).to have_http_status(200)
      end

      it "elimina la encuesta" do
        expect{
          delete api_v1_poll_answer_path(@poll,@answer) , { params: { token: @token.token } }
        }.to change(Answer,:count).by(-1)
      end
    end
    # Con usuario invalido
    context "con usuario invalido" do
      before :each do
        new_user = FactoryGirl.create(:dummy_user)
        @new_token = FactoryGirl.create(:token , user: new_user , expires_at: DateTime.now + 1.month)
        @answer = FactoryGirl.create(:answer,question_id:@question.id)
      end

      it "responde con un status 200" do
        delete api_v1_poll_answer_path(@poll,@answer) , { params: { token: @new_token.token } }
        expect(response).to have_http_status(401)
      end

      it "elimina la encuesta" do
        expect{
          delete api_v1_poll_answer_path(@poll,@answer) , { params: { token: @new_token.token } }
        }.to change(Answer,:count).by(0)
      end
    end
  end

end
