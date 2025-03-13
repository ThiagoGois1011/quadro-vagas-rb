class AddStatusToJobPostings < ActiveRecord::Migration[8.0]
  def change
    add_column :job_postings, :status, :integer
  end
end
