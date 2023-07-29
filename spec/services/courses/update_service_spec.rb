require 'rails_helper'

RSpec.describe Courses::UpdateService do
  let!(:course) { create(:course) }

  subject { described_class.new(course, params).call }

  context "when updating course only" do
    let(:params) { { name: 'Updated Course' } }

    it 'updates the course' do
      subject
      expect(course.reload.name).to eq('Updated Course')
    end
  end

  context 'when invalid params are passed' do
    let(:params) { { name: '' } }

    it 'does not update the course' do
      subject
      expect(course.errors[:name]).to eq(["can't be blank"])
      expect(course.reload.name).not_to be_empty
    end
  end
end
