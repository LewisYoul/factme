require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET index' do
    it 'returns 200 OK' do
      get :index

      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(get :index).to render_template(:index)
    end
  end

  describe 'GET new' do
    it 'returns 200 OK' do
      get :new

      expect(response).to have_http_status(:ok)
    end

    it 'assigns a new post for the view to use' do
      get :new

      expect(assigns(:post)).to be_a(Post)
    end

    it 'renders the NEW template' do
      expect(get :new).to render_template(:new)
    end
  end

  describe 'POST create' do
    let(:params) do
      {
        title: 'Test Title',
        body_one: 'Body one',
        gist: 'gist url',
        body_two: 'Body two'
      }
    end

    let(:post_create_action) do
      post :create, params: { post: params }
    end

    context 'when the params are valid' do
      it 'creates a new post' do
        expect { post_create_action }.to change { Post.count }.by(1)
      end

      it 'redirects to the index endpoint' do
        expect(post_create_action).to redirect_to(:posts)
      end
    end

    context 'when the saving of the Post fails' do
      let(:params) do
        {
          not_permitted: 'Not permitted param',
          body_one: 'Body one',
          gist: 'gist url',
          body_two: 'Body two'
        }
      end

      let(:mock_post) { instance_double(Post, save: false) }

      before { allow(Post).to receive(:new).and_return(mock_post) }

      it 'does not create a new post' do
        expect { post_create_action }.not_to change { Post.count }
      end

      it 'redirects to the new endpoint' do
        expect(post_create_action).to render_template(:new)
      end
    end
  end
end
