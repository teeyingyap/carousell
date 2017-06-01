require 'rails_helper'

RSpec.describe User, type: :model do

 context "validations" do
    it "should have username and email and password_digest" do
      should have_db_column(:username).of_type(:string)
      should have_db_column(:email).of_type(:string)
      should have_db_column(:password_digest).of_type(:string)
    end

    describe "validates presence and uniqueness of name and email" do
      it { is_expected.to validate_presence_of(:email).with_message("*Email is a required field") }
      it { is_expected.to validate_presence_of(:username).with_message("*Username is a required field") }
      it { is_expected.to validate_uniqueness_of(:email) }
      it { is_expected.to validate_uniqueness_of(:username) }
    end

    describe "validates password" do 
      it { is_expected.to validate_presence_of(:password) }
      #it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(20).with_message("*Password must be within 8 to 20 characters") }
    end


   describe "should permit valid password only" do
    let(:user1) { User.create(username: "jack", email: "jack@mail.com") }
    let(:user2) { User.create(username: "jack", email: "jack@mail.com", password: 'short') }
      it "should not be valid without a password" do
        expect(user1).to be_invalid
      end

      it "should not be valid with a short password" do
        expect(user2).to be_invalid
      end

    end

 
     describe "should permit valid email only" do
      let(:user1) { User.create(username: "john", email: "john@mail.com", password: "12345678")}
      let(:user2) { User.create(username: "phineas", email: "google.com", password: "12345678") }
      # happy_path
      it "sign up with valid email" do
        expect(user1).to be_valid
      end

      # unhappy_path
      it "sign up with invalid email" do
        expect(user2).to be_invalid
      end

    end
    



    # happy_path
    describe "can be created when all attributes are present" do
      let(:user1) { User.create(username: "jack", email: "jack@mail.com", password: "12345678") }
       it "should be valid with all attributes" do
        expect(user1).to be_valid
      end

    end

    # unhappy_path
    describe "should permit valid username only" do
      let(:user1) { User.create(email: "jack@gmail.com", password: "12345678") }
        it "should be invalid without a username" do
          expect(user1).to be_invalid
        end
    end

 
  end

    context 'associations with dependency' do
    it { is_expected.to have_many(:listings).dependent(:destroy)}
    it { is_expected.to have_many(:comments).dependent(:destroy)}
  end

end   