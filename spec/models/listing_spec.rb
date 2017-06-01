require 'rails_helper'

RSpec.describe Listing, type: :model do
  context 'associations with dependency' do
    it { is_expected.to have_many(:transactions).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy)}
    it { is_expected.to belong_to(:user) }
  end

  describe "validates presence and uniqueness of name and email" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:condition) }
  end
end
