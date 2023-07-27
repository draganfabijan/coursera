require 'rails_helper'

RSpec.describe Vertical, type: :model do
  describe 'associations' do
    it { should have_many(:categories).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    context 'name uniqueness across categories and verticals' do
      context 'when name is different from any Category name' do
        let(:vertical) { build(:vertical, name: 'Different Name') }

        it 'is valid' do
          expect(vertical).to be_valid
        end
      end

      context 'when name is the same as a Category name' do
        let!(:category) { create(:category, name: 'Test') }
        let(:vertical) { build(:vertical, name: 'Test') }

        it 'is not valid' do
          expect(vertical).not_to be_valid
          expect(vertical.errors[:name]).to include('must be unique across Categories and Verticals')
        end
      end
    end
  end
end
