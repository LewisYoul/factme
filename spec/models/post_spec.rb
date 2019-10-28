require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post_serializer) { instance_double(PostSerializer, to_json: true) }

  subject(:post) do
    Post.create!(
      title: 'Title',
      synopsis: 'Synopsis',
      body_one: 'Body'
    )
  end

  describe '#serializable' do
    before do
      allow(PostSerializer).to receive(:new).with(post).and_return(post_serializer)
      post.serializable
    end

    it 'invokes the post serializer' do
      expect(PostSerializer).to have_received(:new).with(post)
    end

    it 'converts the post serializer to json' do
      expect(post_serializer).to have_received(:to_json).with no_args
    end
  end
end
