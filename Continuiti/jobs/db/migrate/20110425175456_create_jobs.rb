class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :jobtype_id
      t.string :job_title
      t.string :job_detail_description
      t.string :job_detail_private
      t.string :task_start_time_date
      t.string :task_completed_by_time_date
      t.string :your_time_estimate
      t.float :your_cost_estimate_per_hour
      t.float :your_estimated_expense_to_do_task
      t.string :total_cost_calculated
      t.string :vehicle_required
      t.string :action_chosen
      t.boolean :make_template

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
