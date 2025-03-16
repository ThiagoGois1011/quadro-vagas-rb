class ProcessTxtJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    File.foreach(file_path) do |line|
      ProcessLineJob.perform_later(line)
    end
  end
end
