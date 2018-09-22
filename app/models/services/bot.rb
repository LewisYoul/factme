module Services
  class Bot

    def send_tweet
      twitter.update(obtain_fact)
    end

    def obtain_fact
      month = Date.today.month
      day = Date.today.day
      res = Typhoeus.get("http://numbersapi.com/#{month}/#{day}/date")
      res.body
    end

    private

    def twitter
      @twitter ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['consumer_key']
        config.consumer_secret     = ENV['consumer_secret']
        config.access_token        = ENV['access_token']
        config.access_token_secret = ENV['access_secret']
      end
    end
  end
end
