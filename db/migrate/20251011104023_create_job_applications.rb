class CreateJobApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :job_applications do |t|
      t.string :company_name, null: false
      t.string :job_title, null: false
      t.string :application_link
      t.date :application_date, null: false
      t.string :current_status, null: false, default: "applied"
      t.datetime :status_updated_at
      t.string :rejected_at_stage
      t.integer :salary_range_min
      t.integer :salary_range_max
      t.string :contact_name
      t.string :contact_email
      t.text :notes
      t.date :follow_up_date

      t.timestamps
    end

    add_index :job_applications, :company_name
    add_index :job_applications, :current_status
    add_index :job_applications, :application_date
    add_index :job_applications, :follow_up_date
  end
end
