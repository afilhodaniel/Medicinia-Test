require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    FactoryGirl.create(:user)
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    
    it { should validate_uniqueness_of(:email) }
    
    it { should have_secure_password }
  end

  context "relationships" do
    it { should have_many(:notifications) }
    it { should have_many(:comments) }
  end
end