class ProcessTxtJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    processed_lines = 0
    File.foreach(file_path) do |line|
      ProcessLineJob.perform_later(line)
      processed_lines += 1
      sleep 5
      ActionCable.server.broadcast("progress_channel", {
        processed: processed_lines
      })
    end
  end
end
