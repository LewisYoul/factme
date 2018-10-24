require 'rails_helper'

RSpec.describe AboutController, type: :controller do
  describe 'GET index' do
      it 'returns 200 OK' do
        get :index
  
        expect(response).to have_http_status(:ok)
      end
  
      it 'renders the about page template' do
        expect(get :index).to render_template(:index)
      end
    end
end
