require 'rails_helper'

RSpec.describe Verticals::UpdateService do
  let!(:vertical) { create(:vertical) }
  let!(:category) { create(:category, vertical: vertical) }
  let!(:course) { create(:course, category: category) }

  subject { Verticals::UpdateService.new(vertical, params).call }

  context "when updating vertical only" do
    let(:params) { { name: 'Updated Vertical' } }

    it 'updates the vertical' do
      subject
      expect(vertical.reload.name).to eq('Updated Vertical')
    end
  end

  context "when updating vertical and category" do
    let(:params) {
      {
        name: 'Updated Vertical',
        categories_attributes: [
          {
            id: category.id,
            name: 'Updated Category'
          }
        ]
      }
    }

    it 'updates the vertical and category' do
      subject
      expect(vertical.reload.name).to eq('Updated Vertical')
      expect(category.reload.name).to eq('Updated Category')
    end
  end

  context "when updating vertical, category, and course" do
    let(:params) {
      {
        name: 'Updated Vertical',
        categories_attributes: [
          {
            id: category.id,
            name: 'Updated Category',
            courses_attributes: [
              {
                id: course.id,
                name: 'Updated Course'
              }
            ]
          }
        ]
      }
    }

    it 'updates the vertical, category, and course' do
      subject
      expect(vertical.reload.name).to eq('Updated Vertical')
      expect(category.reload.name).to eq('Updated Category')
      expect(course.reload.name).to eq('Updated Course')
    end
  end

  context 'when updating vertical and creating category, and course' do
    let(:params) do
      {
        name: 'Updated Vertical Name',
        categories_attributes: [
          {
            name: 'New Category Name',
            state: 'active',
            courses_attributes: [
              {
                name: 'New Course Name',
                state: 'active',
                author: 'New Author'
              }
            ]
          }
        ]
      }
    end

    subject(:update_service) { described_class.new(vertical, params) }

    it 'updates the vertical and creates a new category and course' do
      expect { update_service.call }
        .to change { vertical.reload.name }.from(vertical.name).to('Updated Vertical Name')
        .and change(Category, :count).by(1)
        .and change(Course, :count).by(1)

      new_category = Category.last
      new_course = Course.last

      expect(new_category.name).to eq('New Category Name')
      expect(new_category.state).to eq('active')
      expect(new_category.vertical).to eq(vertical)

      expect(new_course.name).to eq('New Course Name')
      expect(new_course.state).to eq('active')
      expect(new_course.author).to eq('New Author')
      expect(new_course.category).to eq(new_category)
    end
  end

  context 'when invalid params are passed' do
    let(:params) { { name: '' } }

    it 'does not update the vertical' do
      subject
      expect(vertical.errors[:name]).to eq(["can't be blank"])
      expect(vertical.reload.name).not_to be_empty
    end
  end

  context 'when valid params are passed for vertical and invalid for category' do
    let(:params) do
      {
        name: 'New Vertical Name',
        categories_attributes: [
          {
            id: category.id,
            name: ''
          }
        ]
      }
    end

    it 'does not update the vertical or the category' do
      subject

      expect(vertical.reload.name).not_to eq('New Vertical Name')
      expect(category.reload.name).not_to be_empty
    end
  end

end
