class AddPostJob < ActiveRecord::Migration
  def self.up
    add_column :jobs, :dress_code, :string
    add_column :jobs, :functional_area, :string
    add_column :jobs, :primary_task, :string
    add_column :jobs, :dates_type, :integer, :limit => 1
    add_column :jobs, :duration_notes, :text
    add_column :jobs, :hourly_rate, :integer, :limit => 3
    add_column :jobs, :annual_rate, :integer
    add_column :jobs, :bring_instruction, :text
  end

  def self.down
    remove_column :jobs, :dress_code
    remove_column :jobs, :functional_area
    remove_column :jobs, :primary_task
    remove_column :jobs, :dates_type
    remove_column :jobs, :duration_notes
    remove_column :jobs, :hourly_rate
    remove_column :jobs, :annual_rate
    remove_column :jobs, :bring_instruction
  end
end
