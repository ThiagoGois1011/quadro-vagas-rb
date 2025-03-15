class ProcessTxtJob < ApplicationJob
  queue_with_priority :default

  def perform(file_path)
    job_futures = []
    File.foreach(file_path) do |line|
      ProcessLineJob.perform_later(line)
    end
  end
end
