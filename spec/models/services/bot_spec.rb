require 'rails_helper'

RSpec.describe Services::Bot do

  let(:twitter_class) { Twitter::REST::Client }

  let(:twitter_client) do
    instance_double(Twitter::REST::Client, update: 'cool')
  end

  before do
    allow(twitter_class).to receive(:new).and_return(twitter_client)
  end

  describe '#send_tweet' do
    it 'instantiates the twitter client' do
      described_class.new.send_tweet

      expect(twitter_class).to have_received(:new)
    end

    it 'calls #update on the twitter client' do
      described_class.new.send_tweet

      expect(twitter_client).to have_received(:update)
    end
  end
end
