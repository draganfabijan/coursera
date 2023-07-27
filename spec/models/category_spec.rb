require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should belong_to(:vertical) }
    it { should have_many(:courses).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:state) }

    context 'name uniqueness across categories and verticals' do
      context 'when name is different from any Vertical name' do
        let(:category) { build(:category, name: 'Different Name') }

        it 'is valid' do
          expect(category).to be_valid
        end
      end

      context 'when name is the same as a Vertical name' do
        let!(:vertical) { create(:vertical, name: 'Test') }
        let(:category) { build(:category, name: 'Test') }

        it 'is not valid' do
          expect(category).not_to be_valid
          expect(category.errors[:name]).to include('must be unique across Categories and Verticals')
        end
      end
    end
  end
end
