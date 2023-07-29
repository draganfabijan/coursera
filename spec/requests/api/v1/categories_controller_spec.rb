require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do

  describe 'GET #index' do
    let!(:category1) { create(:category) }
    let!(:category2) { create(:category) }

    before do
      authenticate_request

      allow_any_instance_of(Category).to receive(:reindex).and_call_original
      Category.reindex
      get :index
    end

    subject { get :index }

    it { is_expected.to have_http_status(:success) }

    it 'returns all categories' do
      subject

      parsed_response = JSON.parse(response.body)
      expect(parsed_response.count).to eq(2)
    end
  end

  describe 'PUT #update' do
    let(:category) { instance_double('Category', persisted?: true) }
    let(:valid_attributes) { ActionController::Parameters.new({ name: 'Some Category' }).permit! }
    let(:active_model_errors_double) { instance_double('ActiveModel::Errors') }

    before do
      authenticate_request
      allow(Category).to receive(:find).and_return(category)
      allow(category).to receive(:errors).and_return(active_model_errors_double)
    end

    subject { put :update, params: { id: 1, category: valid_attributes } }

    context 'when the update is successful' do
      let(:service_instance) { instance_double('Categories::UpdateService', call: true) }

      before do
        allow(Categories::UpdateService).to receive(:new).with(category, valid_attributes).and_return(service_instance)
      end

      it 'calls :call on the service instance and returns the updated category' do
        expect(service_instance).to receive(:call)
        subject

        expect(response.status).to eq(200)
        expect(response.body).to eq(category.to_json)
      end
    end

    context 'when service returns false' do
      let(:service_instance) { instance_double('Categories::UpdateService', call: false) }

      before do
        allow(Categories::UpdateService).to receive(:new).with(category, valid_attributes).and_return(service_instance)
      end

      it 'calls :call on the service instance and returns status code 422' do
        expect(service_instance).to receive(:call)
        subject

        expect(response.status).to eq(422)
      end
    end

    context 'when record is not found' do
      before do
        allow(Category).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
      end

      it { is_expected.to have_http_status(:not_found) }
    end
  end
end
