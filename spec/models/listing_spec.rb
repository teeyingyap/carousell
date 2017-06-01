require 'rails_helper'

RSpec.describe Listing, type: :model do

   context "validations" do
     it "should have user_id" do
       should have_db_column(:user_id).of_type(:integer)
     end

     describe "validates presence of attributes" do
       it { is_expected.to validate_presence_of(:name) }
       it { is_expected.to validate_presence_of(:price) }
       it { is_expected.to validate_presence_of(:condition) }
     end

  end

  context 'associations with dependency' do
    it { is_expected.to have_many(:transactions).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy)}
    it { is_expected.to belong_to(:user) }
  end


end
 