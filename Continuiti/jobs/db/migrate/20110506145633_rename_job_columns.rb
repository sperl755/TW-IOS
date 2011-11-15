class RenameJobColumns < ActiveRecord::Migration
  def self.up
    rename_column :jobs, :time_unit, :time_unit_id
    rename_column :jobs, :cost_method_of_service, :cost_method_id
    rename_column :jobs, :vehicle_required, :vehicle_id
    
  end

  def self.down
    rename_column :jobs, :time_unit_id, :time_unit
    rename_column :jobs, :cost_method_id, :cost_method_of_service
    rename_column :jobs, :vehicle_id, :vehicle_required
  end
end
