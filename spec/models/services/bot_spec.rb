require 'rails_helper'

RSpec.describe Services::Bot do

  let(:twitter_class) { class_double(Twitter::REST::Client).as_stubbed_const }
  let(:twitter_client) do
    instance_double(Twitter::REST::Client, update: 'cool')
  end

  let(:numbers_class) do
    class_double(Services::Integration::Numbers).as_stubbed_const
  end
  let(:numbers_client) do
    instance_double(Services::Integration::Numbers, fact_for_today: fact)
  end

  let(:fact) { 'fact' }

  before do
    allow(twitter_class).to receive(:new).and_return(twitter_client)
    allow(numbers_class).to receive(:new).and_return(numbers_client)
  end

  describe '#tweet_todays_fact' do
    it 'instantiates the numbers api integration client' do
      described_class.new.tweet_todays_fact

      expect(numbers_class).to have_received(:new)
    end

    it 'calls #fact_for_today on the numbers api client' do
      described_class.new.tweet_todays_fact

      expect(numbers_client).to have_received(:fact_for_today)
    end

    it 'instantiates the twitter client' do
      described_class.new.tweet_todays_fact

      expect(twitter_class).to have_received(:new)
    end

    it 'calls #update on the twitter client' do
      described_class.new.tweet_todays_fact

      expect(twitter_client).to have_received(:update)
    end

    it 'creates a new Tweet record' do
      expect { described_class.new.tweet_todays_fact }
        .to change { Tweet.count }.from(0).to(1)
    end

    it 'sets the fact returned from the numbers API as the text attribute' do
      described_class.new.tweet_todays_fact

      expect(Tweet.last.text).to eq(fact)
    end

    it 'returns the fact that was tweeted' do
      expect(described_class.new.tweet_todays_fact)
        .to eq(numbers_client.fact_for_today)
    end
  end
end
