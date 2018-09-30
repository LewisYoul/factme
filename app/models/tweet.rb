class Tweet < ApplicationRecord

  def self.same_as_this_day_last_year?(fact)
    Tweet.where(created_at: this_day_last_year)
      .any? { |tweet| tweet.text == fact }
  end

  private

  def self.this_day_last_year
    1.year.ago.beginning_of_day..1.year.ago.end_of_day
  end
end
