require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do

  # describe "GET #index" do
  #   it "returns http success" do
  #     get :index
  #     expect(response).to have_http_status(200)
  #   end
  # end

  describe "POST /users" do
    before :each do
      auth = { provider: "facebook" , uid:"aknsjans" , info:{ email:"asjnaj@jasnacom.com" , name:"jnasan hasa" } }
      post "/api/v1/users" , { params:{ auth: auth } }
    end

    it { have_http_status(200) }

    it { change(User,:count).by(1) }

    it "response with user info" do
      json = JSON.parse(response.body)
      puts "\n\n\n--#{json}--"
    end

  end
end
