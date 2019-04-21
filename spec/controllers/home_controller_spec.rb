RSpec.describe HomeController, type: :controller do
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

    let(:page_param_parser) do
      instance_double(Services::PageParamParser, parse: 1)
    end

    before do
      allow(Services::PageParamParser).to receive(:new).and_return(page_param_parser)
    end

    it 'offsets the posts according to the current page param' do
      allow(page_param_parser).to receive(:parse).and_return(2)

      get :index

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
      allow(page_param_parser).to receive(:parse).and_return(2)

      get :index
      
      expect(assigns(:previous_page)).to eq(1)
    end

    it 'invokes the page param parser' do
      get :index
      
      expect(Services::PageParamParser).to have_received(:new).with(page_param: nil)
    end

    it 'calls the page param parser' do
      get :index
      
      expect(page_param_parser).to have_received(:parse).with no_args
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
    end

    context 'when the current page is not the last' do
      it 'assigns the is_last_page variable as false' do
        get :index
        
        expect(assigns(:is_last_page)).to eq(false)
      end
    end

    context 'when the current page is the last' do
      before do
        allow(page_param_parser).to receive(:parse).and_return(2)
      end

      it 'assigns the is_last_page variable as true' do
        get :index
        
        expect(assigns(:is_last_page)).to eq(true)
      end

      it 'assigns the is_first_page variable as false' do
        get :index
        
        expect(assigns(:is_first_page)).to eq(false)
      end
    end
  end
end