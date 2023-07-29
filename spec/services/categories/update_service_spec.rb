require 'rails_helper'

RSpec.describe Categories::UpdateService do
  let!(:vertical) { create(:vertical) }
  let!(:category) { create(:category, vertical: vertical) }
  let!(:course) { create(:course, category: category) }

  subject { Categories::UpdateService.new(category, params).call }

  context "when updating category only" do
    let(:params) { { name: 'Updated Category' } }

    it 'updates the category' do
      subject
      expect(category.reload.name).to eq('Updated Category')
    end
  end

  context "when updating category and course" do
    let(:params) {
      {
        name: 'Updated Category',
        courses_attributes: [
          {
            id: course.id,
            name: 'Updated Course'
          }
        ]
      }
    }

    it 'updates the category and course' do
      subject
      expect(category.reload.name).to eq('Updated Category')
      expect(course.reload.name).to eq('Updated Course')
    end
  end

  context 'when updating category and creating course' do
    let(:params) do
      {
        name: 'Updated Category',
        courses_attributes: [
          {
            name: 'New Course Name',
            state: 'active',
            author: 'New Author'
          }
        ]
      }
    end

    subject(:update_service) { described_class.new(category, params) }

    it 'updates the category and creates a new course' do
      expect { update_service.call }
        .to change { category.reload.name }.from(category.name).to('Updated Category')
        .and change(Course, :count).by(1)

      new_course = Course.last

      expect(new_course.name).to eq('New Course Name')
      expect(new_course.state).to eq('active')
      expect(new_course.author).to eq('New Author')
      expect(new_course.category).to eq(category)
    end
  end

  context 'when invalid params are passed' do
    let(:params) { { name: '' } }

    it 'does not update the category' do
      subject
      expect(category.errors[:name]).to eq(["can't be blank"])
      expect(category.reload.name).not_to be_empty
    end
  end

  context 'when valid params are passed for category and invalid for course' do
    let(:params) do
      {
        name: 'New Category Name',
        courses_attributes: [
          {
            id: course.id,
            name: ''
          }
        ]
      }
    end

    it 'does not update the category or the course' do
      subject

      expect(category.reload.name).not_to eq('New Category Name')
      expect(course.reload.name).not_to be_empty
    end
  end

end
