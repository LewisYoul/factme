class Bot < ApplicationRecord

  def self.send_tweet
    CLIENT.update(obtain_fact)
  end

  def self.obtain_fact
    month = Date.today.month
    day = Date.today.day
    res = Typhoeus.get("http://numbersapi.com/#{month}/#{day}/date")
    res.body
  end
end
