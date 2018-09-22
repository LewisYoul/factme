require 'sidekiq-scheduler'

class DailyTweetWorker
  include Sidekiq::Worker

  def perform
    bot.tweet_todays_fact
  end

  private

  def bot
    @bot ||= Services::Bot.new
  end
end
