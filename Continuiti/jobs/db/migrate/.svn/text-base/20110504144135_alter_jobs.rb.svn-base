class AlterJobs < ActiveRecord::Migration
  def self.up
    add_column :task_locations, :task_location_type_id, :integer, :default => 0
    add_column :jobs, :cost_method_of_service, :integer, :default => 0
    add_column :jobs, :time_unit, :string
    add_column :jobs, :cost_per_time_unit, :string
    add_column :jobs, :fixed_cost_amount, :string
    add_column :jobs, :average_expected_cost, :string
    add_column :jobs, :average_expected_time, :string
    add_column :jobs, :custom_quote_factors, :string
    add_column :jobs, :job_skills, :string
    change_column :jobs, :vehicle_required, :integer
  end

  def self.down
    remove_column :task_locations, :task_location_type_id
    remove_column :jobs, :cost_method_of_service
    remove_column :jobs, :time_unit
    remove_column :jobs, :cost_per_time_unit
    remove_column :jobs, :fixed_cost_amount
    remove_column :jobs, :average_expected_cost
    remove_column :jobs, :average_expected_time
    remove_column :jobs, :custom_quote_factors
    remove_column :jobs, :job_skills
    change_column :jobs, :vehicle_required, :string
  end
  
end
