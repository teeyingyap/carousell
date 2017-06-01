require 'rails_helper'

RSpec.describe Transaction, type: :model do
   context "validations" do
     it "should have user_id and listing_id" do
       should have_db_column(:user_id).of_type(:integer)
       should have_db_column(:listing_id).of_type(:integer)
     end
  end

  context 'associations with dependency' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:listing) }
  end
end
 