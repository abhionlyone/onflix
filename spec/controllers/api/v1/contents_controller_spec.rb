require 'rails_helper'

RSpec.describe Api::V1::ContentsController, type: :controller do
  let(:movie) { create :movie }
  let(:movie_params) { attributes_for :movie }
  let(:variant) { create :variant }
  let(:variant_params) { attributes_for :variant }
  let(:pruchase) { create :purchase }
  let(:pruchase_params) { attributes_for :pruchase }
  describe 'GET List all Movies/Seasons in the application' do
    context 'without a valid user access-token in header' do
      it 'returns HTTP status 401' do
        request.headers.merge!({ 'Accept': 'application/json', 'access-token': nil, 'email': nil })
        get :index, params: {}
        body = JSON.parse(response.body)
        expect(response).to have_http_status 401
      end
    end
    context 'with a valid user access-token in header' do
        it 'returns HTTP status 200' do
          user = FactoryGirl.create(:user)
          request.headers.merge!({ 'Accept': 'application/json', 'access-token': user.create_token, 'uid': user.email })
          get :index
          body = JSON.parse(response.body)
          expect(response).to have_http_status 200
        end
    end
  end
  describe 'POST Purchase a Movie/Season' do
    context 'Purchasing content(Duplicate purchase)' do
      it 'returns HTTP status 401' do
        user = FactoryGirl.create(:user)
        content = FactoryGirl.create(:movie)
        variant = FactoryGirl.create(:variant, content_id: content.id)
        purchase = FactoryGirl.create(:purchase, content_id: content.id, variant_id: variant.id, user_id: user.id)
        request.headers.merge!({ 'Accept': 'application/json', 'access-token': user.create_token, 'uid': user.email })
        post :purchase, params: {variant_id: variant.id}
        body = JSON.parse(response.body)
        expect(response).to have_http_status 422
      end
    end
    context 'Purchasing content(Duplicate purchase)' do
        it 'returns HTTP status 201' do
          user = FactoryGirl.create(:user)
          content = FactoryGirl.create(:movie)
          variant = FactoryGirl.create(:variant, content_id: content.id)
          request.headers.merge!({ 'Accept': 'application/json', 'access-token': user.create_token, 'uid': user.email })
          post :purchase, params: {variant_id: variant.id}
          expect(response).to have_http_status 201
        end
    end
  end
end
