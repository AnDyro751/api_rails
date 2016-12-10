require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :request do

  before :each do
    @token = FactoryGirl.create(:token , expires_at: DateTime.now + 10.minutes)
    @poll = FactoryGirl.create(:poll_with_question,user:@token.user)
  end

  describe "GET /polls/:poll_id/questions" do
    before :each do
      get "/api/v1/polls/#{@poll.id}/questions"
    end
    it { expect(response).to have_http_status(200) }
    it "mandar la lista de preguntas de la encuesta" do
      json = JSON.parse(response.body)
      # puts "\n\n----#{json}"
      expect(json.length).to eq(@poll.questions.count)
    end
    it "manda la descripcion y el id de la pregunta" do
      json_array = JSON.parse(response.body)
      question = json_array[0]
      expect(question.keys).to contain_exactly("id","description")
    end
  end

  describe "POST /poll/:poll_id/questions" do
    before :each do
      post api_v1_poll_questions_path(@poll) , { params: { question: { description: "Cual es tu lenguej favoito?" },token: @token.token } }
    end
    it { expect(response).to have_http_status(200) }

    context "con usuario válido" do
      it "cambia el contador +1" do
        expect{
          post api_v1_poll_questions_path(@poll) , { params: { question: { description: "Cual es tu lenguej favoito?" },token: @token.token } }
        }.to change(Question,:count).by(1)
      end

      it "responde con la encuesta creada" do
        json = JSON.parse(response.body)
        expect(json["description"]).to eq("Cual es tu lenguej favoito?")
      end

      it "responde con los atributos de la encuesta" do
        json = JSON.parse(response.body)
        expect(json.keys).to contain_exactly("id","description")
      end
    end

    context "con usuario invalido" do
      before :each do
        new_user = FactoryGirl.create(:dummy_user)
        @new_token = FactoryGirl.create(:token , user: new_user , expires_at: DateTime.now + 1.month)
        post api_v1_poll_questions_path(@poll) , { params: { question: { description: "Cual es tu lenguej favoito?" },token: @new_token.token } }
      end

      it { expect(response).to have_http_status(401) }
      it "cambia el contador +1" do
        expect{
          post api_v1_poll_questions_path(@poll) , { params: { question: { description: "Cual es tu lenguej favoito?" },token: @new_token.token } }
        }.to change(Question,:count).by(0)
      end
    end
  end

end
