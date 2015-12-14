require 'rails_helper'

RSpec.describe Question, type: :model do
  # it 'validates presence of title' do
  #   question = Question.new(body: 'test_body')
  #   expect(question).not_to be_valid
  # end

  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:body)}

end
