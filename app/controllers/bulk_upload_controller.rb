class BulkUploadController < ApplicationController
  def upload
  end

  def process_data
    uploaded_file = params[:upload]

    return render :upload, status: :unprocessable_entity unless uploaded_file

    file_path = Rails.root.join("tmp", uploaded_file.original_filename)
    File.open(file_path, "wb") { |file| file.write(uploaded_file.read) }

    ProcessTxtJob.perform_later(file_path.to_s)

    redirect_to bulk_status_path, notice: "Arquivo recebido com sucesso."
  end

  def bulk_status
  end
end
