RSpec.describe Services::Integration::Numbers do

  let(:typhoeus) { class_double(Typhoeus).as_stubbed_const }

  let(:mock_response) do
    OpenStruct.new(body: 'an interesting fact')
  end

  let(:day) { Date.today.day }

  let(:month) { Date.today.month }

  before do
    allow(typhoeus).to receive(:get).and_return(mock_response)
  end

  describe '#obtain_fact' do
    it 'makes a GET request with the correct URL as an argument' do
      described_class.new.fact_for_today

      expect(typhoeus).to have_received(:get).with("http://numbersapi.com/#{month}/#{day}/date")
    end

    it 'returns the response body' do

      expect(described_class.new.fact_for_today).to eq(mock_response.body)
    end
  end
end
