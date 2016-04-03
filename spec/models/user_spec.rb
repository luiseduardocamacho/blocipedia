require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  it {should have_many(:wikis) }


  it {should validate_presence_of (:email)}
  it {should validate_uniqueness_of (:email)}
  it {should validate_length_of(:email).is_at_least(8)}

  it {should allow_value("user@blocipedia.com").for(:email)}
  it {should_not allow_value("userbloccit.com").for(:email)}

  it {should validate_presence_of(:password)}
  it {should validate_length_of(:password).is_at_least(8)}

  describe "attributes" do
    describe User do
      before :each do
        @user = FactoryGirl.create(:user)
      end
      it "should have email" do
        expect(@user).to be_valid
      end
    end
  end

  describe "invalid user" do

    let(:user_with_invalid_name){User.new(name: "", email: "test@test.com")}
    let (:user_with_invalid_email){User.new(name:"Blocipedia User", email: "")}

    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end
end
