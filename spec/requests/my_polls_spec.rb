require "rails_helper"

RSpec.describe Api::V1::MyPollsController, type: :request do
  describe "GET /polls" do
		before :each do
			FactoryGirl.create_list(:my_poll, 9)
			get "/api/v1/polls/"
		end
    it { expect(response).to have_http_status(200) }
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
    it { expect(response).to have_http_status(200) }

    it "mandar la encuesta solicitada" do
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(@poll.id)
    end

    it "manda los atributos correctos de la encuesta" do
      json = JSON.parse(response.body)
      expect(json.keys).to contain_exactly("id","description","expires_at","user_id","title")
    end
  end

  describe "POST /polls" do
    context "Con un token valido" do
      before :each do
        @token = FactoryGirl.create(:token , expires_at: DateTime.now + 3.day)
        post "/api/v1/polls/" , { params: { token: @token.token , my_poll:{title:"Hola mundo" , description:"akmska skajs kajskja" , expires_at: DateTime.now} } }
      end
      it { expect(response).to have_http_status(200) }

      it "crea una nueva encuesta" do
        expect{
          post "/api/v1/polls/" , { params: { token: @token.token , my_poll:{title:"Hola mundo" , description:"akmska skajs kajskja" , expires_at: DateTime.now} } }
        }.to change(MyPoll,:count).by(1)
      end

      it "responde con la encuesta creada" do
        json = JSON.parse(response.body)
        expect(json["title"]).to eq("Hola mundo")
      end
    end

    context "Con un token inválido" do
      before :each do
        post "/api/v1/polls/"
      end
    end

    context "unvalid params" do
      before :each do
        @token = FactoryGirl.create(:token , expires_at: DateTime.now + 3.day)
        post "/api/v1/polls/" , { params: { token: @token.token , my_poll:{title:"Hola mundo" , expires_at: DateTime.now} } }
      end
      it { expect(response).to have_http_status(200) }
      it "response with errors" do
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
        # puts "\n\n\n--#{json}--"
      end
    end
  end

  describe "PATCH /polls/:id" do
    context "con token valido" do
      before :each do
        @token = FactoryGirl.create(:token , expires_at: DateTime.now + 4.minutes)
        @poll = FactoryGirl.create(:my_poll,user:@token.user)
        patch api_v1_poll_path(@poll) , { params:{ token: @token.token,my_poll:{ title:"New title to my first poll" } }}
      end
      it { expect(response).to have_http_status(200) }
      it "actualizar la encuesta correctamente" do
        json = JSON.parse(response.body)
        expect(json["title"]).to eq("New title to my first poll")
      end
    end
  end

  context "con un token invalido" do
    before :each do
      @token = FactoryGirl.create(:token , expires_at: DateTime.now + 4.minutes)
      @poll = FactoryGirl.create(:my_poll,user:FactoryGirl.create(:dummy_user))
      patch api_v1_poll_path(@poll) , { params:{ token: @token.token,my_poll:{ title:"New title to my first poll" } }}
    end
    it { expect(response).to have_http_status(401) }
  end

  describe "DELETE /polls/:id" do
    context "con token valido" do
      before :each do
        @token = FactoryGirl.create(:token , expires_at: DateTime.now + 4.minutes)
        @poll = FactoryGirl.create(:my_poll,user:@token.user)
      end
      it {
        delete api_v1_poll_path(@poll) , { params:{ token: @token.token}}
        expect(response).to have_http_status(200)
      }
      it "elimina la encuesta correctamente" do
        expect{
          delete api_v1_poll_path(@poll) , { params:{ token: @token.token}}
        }.to change(MyPoll,:count).by(-1)
      end
    end
  end

  context "con un token invalido" do
    before :each do
      @token = FactoryGirl.create(:token , expires_at: DateTime.now + 4.minutes)
      @poll = FactoryGirl.create(:my_poll,user:FactoryGirl.create(:dummy_user))
      delete api_v1_poll_path(@poll) , { params:{ token: @token.token}}
    end
    it { expect(response).to have_http_status(401) }
  end
end
