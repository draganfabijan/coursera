require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  let!(:category) { create(:category) }

  describe 'GET #index' do
    let!(:course1) { create(:course, category: category) }
    let!(:course2) { create(:course, category: category) }

    before do
      authenticate_request

      allow_any_instance_of(Course).to receive(:reindex).and_call_original
      Course.reindex
      get :index, params: { category_id: category.id }
    end

    subject { get :index, params: { category_id: category.id } }

    it { is_expected.to have_http_status(:success) }

    it 'returns all courses for the given category' do
      subject

      parsed_response = JSON.parse(response.body)
      expect(parsed_response.count).to eq(2)
    end
  end

  describe 'PUT #update' do
    let(:course) { instance_double('Course', persisted?: true) }
    let(:valid_attributes) { ActionController::Parameters.new({ name: 'Some Course' }).permit! }
    let(:active_model_errors_double) { instance_double('ActiveModel::Errors') }

    before do
      authenticate_request
      allow(Course).to receive(:find).and_return(course)
      allow(course).to receive(:errors).and_return(active_model_errors_double)
    end

    subject { put :update, params: { category_id: category.id, id: 1, course: valid_attributes } }

    context 'when the update is successful' do
      let(:service_instance) { instance_double('Courses::UpdateService', call: true) }

      before do
        allow(Courses::UpdateService).to receive(:new).with(course, valid_attributes).and_return(service_instance)
      end

      it 'calls :call on the service instance and returns the updated course' do
        expect(service_instance).to receive(:call)
        subject

        expect(response.status).to eq(200)
        expect(response.body).to eq(course.to_json)
      end
    end

    context 'when service returns false' do
      let(:service_instance) { instance_double('Courses::UpdateService', call: false) }

      before do
        allow(Courses::UpdateService).to receive(:new).with(course, valid_attributes).and_return(service_instance)
      end

      it 'calls :call on the service instance and returns status code 422' do
        expect(service_instance).to receive(:call)
        subject

        expect(response.status).to eq(422)
      end
    end

    context 'when record is not found' do
      before do
        allow(Course).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
      end

      it { is_expected.to have_http_status(:not_found) }
    end
  end
end
