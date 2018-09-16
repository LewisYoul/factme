class DailyTweetWorker
  include Sidekiq::Worker

  def perform
    puts 'im a worker that worked'
  end
end
