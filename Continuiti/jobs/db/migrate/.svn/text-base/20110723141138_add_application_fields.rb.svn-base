class AddApplicationFields < ActiveRecord::Migration
  def self.up
    add_column :applications, :fixed_cost_amount, :integer
    add_column :applications, :hourly_rate, :integer
    add_column :applications, :annual_salary, :integer
    add_column :applications, :start_date, :date
    add_column :applications, :start_time, :time
    rename_column :jobs, :annual_rate, :annual_salary
  end

  def self.down
    remove_column :applications, :fixed_cost_amount
    remove_column :applications, :hourly_rate
    remove_column :applications, :annual_salary
    remove_column :applications, :start_date
    remove_column :applications, :start_time
    rename_column :jobs, :annual_salary, :annual_rate
  end
end
