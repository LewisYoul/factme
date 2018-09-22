module Services
  class Bot

    def tweet_todays_fact
      twitter.update(fact_for_today)
      fact_for_today
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

    def fact_for_today
      @fact_for_today ||= numbers_client.fact_for_today
    end

    def numbers_client
      @numbers_client ||= Services::Integration::Numbers.new
    end
  end
end
