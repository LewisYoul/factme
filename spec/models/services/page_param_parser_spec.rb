RSpec.describe Services::PageParamParser do
  context 'when the passed param is nil' do
    it 'returns the default page param' do
      expect(described_class.new(page_param: nil).parse)
        .to eq(described_class::DEFAULT_PAGE)
    end
  end
  
  context 'when the passed param represents a negative integer' do
    it 'returns the default page param' do
      expect(described_class.new(page_param: '-1').parse)
        .to eq(described_class::DEFAULT_PAGE)
    end
  end

  context 'when the passed param is string containing only letters' do
    it 'returns the default page param' do
      expect(described_class.new(page_param: 'lkjhyuh').parse)
        .to eq(described_class::DEFAULT_PAGE)
    end
  end
  
  context 'when the passed param is a string representing a positive integer' do
    it 'returns the default page param' do
      expect(described_class.new(page_param: '3').parse).to eq(3)
    end
  end
end