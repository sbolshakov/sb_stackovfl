require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:questions) }

  describe '#author_of?' do
    let!(:user) { FactoryGirl.create(:user) }

    it 'return true if user is author of object' do
      object = FactoryGirl.create(:question, user: user)
      # expect(user.author_of?(object)).to be_truthy
      expect(user).to be_author_of(object)
    end

    it 'return false if user is not author of object' do
      object = FactoryGirl.create(:question)
      expect(user).not_to be_author_of(object)
    end
  end

end
