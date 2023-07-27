require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should belong_to(:vertical) }
    it { should have_many(:courses).dependent(:destroy) }
  end
end
