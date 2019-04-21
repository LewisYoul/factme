require 'rails_helper'

RSpec.describe PostsController, type: :controller do
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

  describe 'GET edit' do
    let(:post) do 
      Post.create(title: 'title', synopsis: 'synopsis', body_one: 'body')
    end

    it 'returns 200 OK' do
      get :edit, params: { id: post.id }

      expect(response).to have_http_status(:ok)
    end

    it 'assigns the correct post to be rendered in the view' do
      get :edit, params: { id: post.id }

      expect(assigns(:post)).to eq(post)
    end

    it 'renders the EDIT template' do
      expect(get :edit, params: { id: post.id })
        .to render_template(:edit)
    end
  end

  describe 'PUT update' do
    let(:post) do 
      Post.create(title: 'title', synopsis: 'synopsis', body_one: 'body')
    end

    let(:post_params) do
      {
        title: 'Test Title',
        synopsis: 'Synopsis',
        body_one: 'Body one'
      }
    end

    let(:params) do
      { 
        id: post.id,
        post: post_params
      }
    end

    it 'changes the attributes of the given post' do
      put :update, params: params

      expect(post.reload.attributes.slice('title', 'synopsis', 'body_one').values)
        .to contain_exactly(
          post_params[:title],
          post_params[:synopsis],
          post_params[:body_one]
        )
    end

    it 'redirects to the root url' do
      expect(put :update, params: params).to redirect_to(:root)
    end

    context 'when the post fails to update' do
      let(:post_double) { instance_double(Post, update: false) }

      it 're-renders the edit template' do
        allow(Post).to receive(:find).and_return(post_double)

        expect(put :update, params: params).to render_template(:edit)
      end
    end

  end

  describe 'POST create' do
    let(:tag_1) { Tag.create!(name: 'Rails') }
    let(:tag_2) { Tag.create!(name: 'Angular') }

    let(:params) do
      {
        title: 'Test Title',
        synopsis: 'Synopsis',
        body_one: 'Body one',
        tag_ids: [tag_1.id, tag_2.id]
      }
    end

    let(:post_create_action) do
      post :create, params: { post: params }
    end

    context 'when the params are valid' do
      it 'creates a new post' do
        expect { post_create_action }.to change { Post.count }.by(1)
      end

      it 'assigns the passed tags to the post' do
        post_create_action

        expect(Post.last.tags).to contain_exactly(tag_1, tag_2)
      end

      it 'redirects to the root url'do
        expect(post_create_action).to redirect_to(:root)
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
