class AddStaffingPositionsToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :video, :text
    add_column :jobs, :company_description, :text
    add_column :jobs, :compensation, :string
    add_column :jobs, :duration, :string
    add_column :jobs, :hours_per_week, :integer
    add_column :jobs, :requirement_list, :text
    add_column :jobs, :staffing_position_type_id, :integer
    add_column :jobs, :staffing_position_category_id, :integer
  end

  def self.down
    remove_column :jobs, :video
    remove_column :jobs, :company_description
    remove_column :jobs, :compensation
    remove_column :jobs, :duration
    remove_column :jobs, :hours_per_week
    remove_column :jobs, :requirement_list
    remove_column :jobs, :staffing_position_type_id
    remove_column :jobs, :staffing_position_category_id
  end
end
