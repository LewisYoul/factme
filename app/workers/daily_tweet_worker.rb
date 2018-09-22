require 'sidekiq-scheduler'

class DailyTweetWorker
  include Sidekiq::Worker

  def perform
    Bot.tweet_todays_fact
  end
end
