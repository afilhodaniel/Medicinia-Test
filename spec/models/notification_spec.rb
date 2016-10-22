require 'rails_helper'

RSpec.describe Notification, type: :model do
  before do
    FactoryGirl.create(:notification)
  end

  context 'validations' do
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:note) }
    it { should validate_presence_of(:user_id) }
  end

  context 'relationships' do
    it { should have_many(:comments) }
    it { should belong_to(:user) }
  end
end