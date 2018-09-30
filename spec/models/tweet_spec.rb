require 'rails_helper'

RSpec.describe Tweet, type: :model do

  describe '.same_as_this_day_last_year?' do

    before do
      Tweet.create(text: 'same', created_at: 1.year.ago)
    end

    context 'when the passed text is the same as the text of the dates previous tweet' do
      it 'returns true' do
        expect(described_class.same_as_this_day_last_year?('same')).to eq(true)
      end
    end

    context 'when the passed text is not the same as the text of the dates previous tweet' do
      it 'returns false' do
        expect(described_class.same_as_this_day_last_year?('different'))
          .to eq(false)
      end
    end
  end
end
