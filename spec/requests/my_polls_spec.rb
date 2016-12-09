require "rails_helper"

RSpec.describe Api::V1::MyPollsController, type: :request do
  describe "GET /polls" do

		before :each do
			FactoryGirl.create_list(:my_poll, 9)
			get "/api/v1/polls/"
		end

		it "mande la lista de encuestas" do
			json = JSON.parse(response.body)
			expect(json.length).to eq(MyPoll.count )
		end
	end

  describe "GET /polls/:id" do
    before :each do
      @poll = FactoryGirl.create(:my_poll)
			get "/api/v1/polls/#{@poll.id}"
    end
    it { have_http_status(200) }

    it "mandar la encuesta solicitada" do
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(@poll.id)
    end

    it "manda los atributos correctos de la encuesta" do
      json = JSON.parse(response.body)
      expect(json.keys).to contain_exactly("id","description","expires_at","user_id","title")
    end
  end

end
