class JobChangeVehicleCategory < ActiveRecord::Migration
  def self.up
    rename_column :jobs, :vehicle_id, :vehicle
    change_column :jobs, :vehicle, :string
    
  end

  def self.down
    change_column :jobs, :vehicle, :integer
    rename_column :jobs, :vehicle, :vehicle_id
  end
end
