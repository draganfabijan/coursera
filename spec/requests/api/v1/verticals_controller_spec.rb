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
end