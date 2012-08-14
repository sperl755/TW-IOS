class JobAddTimeCategory < ActiveRecord::Migration
  def self.up
    rename_column :jobs, :task_start_time_date, :task_start_date
    change_column :jobs, :task_start_date, :date
    add_column :jobs, :task_start_time, :time
    rename_column :jobs, :task_completed_by_time_date, :task_end_date
    change_column :jobs, :task_end_date, :date
    add_column :jobs, :task_end_time, :time
    add_column :jobs, :task_on_date, :date
    add_column :jobs, :task_on_time, :time
    add_column :jobs, :task_duration_type, :boolean
  end

  def self.down
    rename_column :jobs, :task_start_date, :task_start_time_date
    change_column :jobs, :task_start_time_date, :datetime
    remove_column :jobs, :task_start_time
    rename_column :jobs, :task_end_date, :task_completed_by_time_date
    change_column :jobs, :task_completed_by_time_date, :datetime
    remove_column :jobs, :task_end_time
    remove_column :jobs, :task_on_date
    remove_column :jobs, :task_on_time
    remove_column :jobs, :task_duration_type
  end
end
