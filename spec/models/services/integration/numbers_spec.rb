RSpec.describe Services::Integration::Numbers do

  let(:typhoeus) { class_double(Typhoeus).as_stubbed_const }

  let(:same_fact) do
    OpenStruct.new(body: 'the same fact as last year')
  end

  let(:different_fact) do
    OpenStruct.new(body: 'different fact than last year')
  end

  let(:day) { Date.today.day }

  let(:month) { Date.today.month }

  let!(:created_tweet) do
    Tweet.create(
      text: 'the same fact as last year',
      created_at: 1.year.ago
    )
  end

  before do
    allow(typhoeus).to receive(:get).and_return(different_fact)
  end

  describe '#obtain_fact' do
    it 'makes a GET request with the correct URL as an argument' do
      described_class.new.fact_for_today

      expect(typhoeus).to have_received(:get).with("http://numbersapi.com/#{month}/#{day}/date")
    end

    it 'returns the response body' do
      expect(described_class.new.fact_for_today).to eq(different_fact.body)
    end

    context 'when the obtained tweet is the same as last years' do
      before do
        allow(typhoeus).to receive(:get).and_return(same_fact, different_fact)
      end

      it 'it makes another call to the numbers API to get a new one' do
        described_class.new.fact_for_today

        expect(typhoeus).to have_received(:get).twice
      end
    end
  end
end
