require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of(:email) }
  it { should_not allow_value("anhe@jans").for(:email) }
  it { should allow_value("anhe@jans.com").for(:email) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:uid) }


  it "deberia crear un usuario si los datos no existen" do
    expect{
      User.from_omniauth({uid:"Github",provider:"MyProvider123",info:{email:"angel751@gmail.com",name:"Angel Mendez"}})
    }.to change(User,:count).by(1)
  end

  it "deberia encontrar un usuario si el uid y el provider existen" do
    user = FactoryGirl.create(:user)
    expect{
      User.from_omniauth({provider: user.provider, uid: user.uid})
    }.to change(User,:count).by(0)
    # expect{} Esperamos la ejecucion del metodo
  end

  it "debe retornar un usuario si es que lo encuentra" do
    user = FactoryGirl.create(:user)

    expect(
      User.from_omniauth(uid: user.uid, provider: user.provider)
      # User.from_omniauth(provider:user.provider,uid:user.id)
    ).to eq(user)
    # expect() Esperamos lo que el metodo retorne

  end

end
