RSpec.fdescribe HomeController, type: :controller do
  describe 'GET index' do
    let!(:post_1) { Post.create! }
    let!(:post_2) { Post.create! }
    let!(:post_3) { Post.create! }
    let!(:post_4) { Post.create! }
    let!(:post_5) { Post.create! }
    let!(:post_6) { Post.create! }
    let!(:post_7) { Post.create! }
    let!(:post_8) { Post.create! }
    let!(:post_9) { Post.create! }
    let!(:post_10) { Post.create! }

    it 'offsets the posts according to the current page param' do
      get :index, params: { page: 2 }

      expect(assigns(:posts))
        .to contain_exactly(
          post_1,
          post_2,
          post_3,
          post_4,
          post_5,
        )
    end

    it 'limits the number of posts to 5' do
      get :index
      
      expect(assigns(:posts).count).to eq(5)
    end

    it 'assigns the previous page' do
      get :index, params: { page: 2 }
      
      expect(assigns(:previous_page)).to eq(1)
    end

    it 'assigns the current page' do
      get :index
      
      expect(assigns(:current_page)).to eq(1)
    end
    
    it 'assigns the next page' do
      get :index
      
      expect(assigns(:next_page)).to eq(2)
    end
    
    context 'when the current page is the first page' do
      it 'assigns the is_first_page variable as true' do
        get :index
        
        expect(assigns(:is_first_page)).to eq(true)
      end

      it 'assigns the is_first_page variable as false' do
        get :index, params: { page: 2 }
        
        expect(assigns(:is_first_page)).to eq(false)
      end
    end

    context 'when the current page is not the last' do
      it 'assigns the is_last_page variable as false' do
        get :index
        
        expect(assigns(:is_last_page)).to eq(false)
      end
    end

    context 'when the current page is the last' do
      it 'assigns the is_last_page variable as true' do
        get :index, params: { page: 2 }
        
        expect(assigns(:is_last_page)).to eq(true)
      end
    end

    context 'when the page first loads (there is no page param)' do
      it 'defaults to the first page' do
        get :index

        expect(assigns(:posts))
          .to contain_exactly(
            post_6,
            post_7,
            post_8,
            post_9,
            post_10
          )
      end
    end
  end
end