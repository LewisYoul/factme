class Bot < ApplicationRecord

  def self.send_tweet(tweet)
    CLIENT.update(tweet)
  end

  def self.obtain_fact
    month = Date.today.month
    day = Date.today.day
    res = Typhoeus.get("http://numbersapi.com/#{month}/#{day}/date")
    puts res.body
  end
end
