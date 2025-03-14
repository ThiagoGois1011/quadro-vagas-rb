class BulkUploadController < ApplicationController
  def upload
  end

  def process_data
    puts 'rodando jobs'

    redirect_to bulk_status_path, notice: 'Arquivo recebido com sucesso.'
  end

  def bulk_status
    
  end
end
