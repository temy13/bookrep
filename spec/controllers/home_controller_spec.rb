require 'rails_helper'
require 'support/factory_bot'

describe HomeController do
  let(:user) { create(:user) }

  describe 'GET #index with no login' do

   before { get :index, params: {}, session: {} }
   it 'has a 200 status code' do
     expect(response).to have_http_status(:ok)
   end
   it 'renders the :index template' do
     expect(response).to render_template :index
   end
 end

 describe 'GET #index with login' do
    before do
     login_user user
    end
    before { get :index, params: {}, session: {} }
    it 'has a 200 status code' do
      expect(response).to have_http_status(302)
    end
    it 'renders the :index template' do
      # expect(response).to redirect_to("/questions/new")
      expect(response).to redirect_to("/questions")
    end
end

describe 'GET #terms' do

 before { get :terms, params: {}, session: {} }
 it 'has a 200 status code' do
   expect(response).to have_http_status(:ok)
 end
 it 'renders the :index template' do
   expect(response).to render_template :terms
 end
end

describe 'GET #policy' do

 before { get :policy, params: {}, session: {} }
 it 'has a 200 status code' do
   expect(response).to have_http_status(:ok)
 end
 it 'renders the :index template' do
   expect(response).to render_template :policy
 end
end



end
