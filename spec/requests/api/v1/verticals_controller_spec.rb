require 'rails_helper'

RSpec.describe Api::V1::VerticalsController, type: :controller do
  describe 'GET #index' do
    let!(:vertical1) { create(:vertical) }
    let!(:vertical2) { create(:vertical) }

    before { get :index }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all verticals' do
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.count).to eq(2)
    end
  end

  describe 'PUT #update' do
    let(:vertical) { instance_double('Vertical', persisted?: true) }
    let(:valid_attributes) { ActionController::Parameters.new({ name: 'Health & Fitness' }).permit! }
    let(:active_model_errors_double) { instance_double('ActiveModel::Errors') }

    before do
      allow(Vertical).to receive(:find).and_return(vertical)
      allow(vertical).to receive(:errors).and_return(active_model_errors_double)
    end

    subject { put :update, params: { id: 1, vertical: valid_attributes } }

    context 'when the update is successful' do
      let(:service_instance) { instance_double('Verticals::UpdateService', call: true) }

      before do
        allow(Verticals::UpdateService).to receive(:new).with(vertical, valid_attributes).and_return(service_instance)
      end

      it 'calls :call on the service instance and returns the updated vertical' do
        expect(service_instance).to receive(:call)
        subject

        expect(response.status).to eq(200)
        expect(response.body).to eq(vertical.to_json)
      end
    end

    context 'when service returns false' do
      let(:service_instance) { instance_double('Verticals::UpdateService', call: false) }

      before do
        allow(Verticals::UpdateService).to receive(:new).with(vertical, valid_attributes).and_return(service_instance)
      end

      it 'calls :call on the service instance and returns status code 422' do
        expect(service_instance).to receive(:call)
        subject

        expect(response.status).to eq(422)
      end
    end

    context 'when record is not found' do
      before do
        allow(Vertical).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
      end

      it { is_expected.to have_http_status(:not_found) }
    end
  end
end
