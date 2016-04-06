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

      it "should respond to email" do
        expect(user).to respond_to(:email)
      end

      it "responds to role" do
        expect(user).to respond_to(:role)
      end

      it "responds to admin?" do
        expect(user).to respond_to(:admin?)
      end

      it "responds to standard?" do
        expect(user).to respond_to(:standard?)
      end

      it "responds to premium?" do
        expect(user).to respond_to(:premium?)
      end
    end

  describe "roles" do

    it "is standard by default" do
      expect(user.role).to eql("standard")
    end

    context "standard user" do

      it "should return true for #standard" do
        expect(user.standard?).to be_truthy
      end

      it "should return false for #admin" do
        expect(user.admin?).to be_falsy
      end

      it "should return false for #premium" do
        expect(user.premium?).to be_falsy
      end
    end

    context "admin user" do
      before do
         user.admin!
       end

      it "should return false for #standard" do
        expect(user.standard?).to be_falsy
      end

      it "should return true for #admin" do
        expect(user.admin?).to be_truthy
      end

      it "should return false for #premium" do
        expect(user.premium?).to be_falsy
      end
    end

    context "premium used" do

      before do
         user.premium!
       end

      it "should return false for #standard" do
        expect(user.standard?).to be_falsy
      end

      it "should return false for #admin" do
        expect(user.admin?).to be_falsy
      end

      it "should return true for #premium" do
        expect(user.premium?).to be_truthy
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
