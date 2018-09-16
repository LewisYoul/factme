class DailyTweetWorker
  include Sidekiq::Worker

  def perform
    Bot.send_tweet
    puts 'im a worker that worked'
  end
end
