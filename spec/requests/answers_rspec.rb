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
        expect(valid_params[:description]).to eq(json["description"])
      end

    end

    context "con usuario invalido" do
    end
  end

  describe "PUT / PATCH /polls/:question_id/:id" do
    context "con usuario valido" do
    end
    context "con usuario invalido" do
    end
  end

  describe "DELETE /polls/:question_id/:id" do
    context "when " do
    end
  end

end
