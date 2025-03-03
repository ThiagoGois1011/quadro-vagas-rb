class CreateJobAds < ActiveRecord::Migration[8.0]
  def change
    create_table :job_ads do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
