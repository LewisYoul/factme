namespace :tweets do
  task :send => :environment do
    DailyTweetWorker.perform_async
  end
end
