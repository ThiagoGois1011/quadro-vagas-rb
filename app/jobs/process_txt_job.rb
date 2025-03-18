class ProcessTxtJob < ApplicationJob
  queue_as :default

  def perform(file_path, user_id)
    redis = Redis.new(url: ENV["REDIS_URL"])
    lines = File.readlines(file_path)
    redis.set("job-data-user-#{user_id}-processed-lines", "0")
    redis.set("job-data-user-#{user_id}-remaining-lines", lines.size)
    redis.set("job-data-user-#{user_id}-successful-registrations", "0")
    redis.set("job-data-user-#{user_id}-lines-error", "0")
    puts 'dentro do job txt'
    lines.each { |line| ProcessLineJob.perform_later(line, user_id) } 
    
    File.delete(file_path) if File.exist?(file_path)
  end
end
