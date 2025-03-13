class AddDefaultForStatusInJobPostings < ActiveRecord::Migration[8.0]
  def change
    change_column_default :job_postings, :status, 0
  end
end
