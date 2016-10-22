require 'rails_helper'

RSpec.describe Notification, type: :model do
  before do
    FactoryGirl.create(:notification)
  end

  context 'validations' do
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:note) }
  end
end