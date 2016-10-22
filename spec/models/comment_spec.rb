require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    FactoryGirl.create(:comment)
  end

  context 'validations' do
    it { should validate_presence_of(:comment) }
    it { should validate_presence_of(:notification_id) }
    it { should validate_presence_of(:user_id) }
  end

  context 'relationships' do
    it { should belong_to(:notification) }
    it { should belong_to(:user) }
  end
end