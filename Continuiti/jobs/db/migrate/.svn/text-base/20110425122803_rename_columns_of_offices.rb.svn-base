class RenameColumnsOfOffices < ActiveRecord::Migration
  def self.up
    rename_column :offices, :x_coordinate, :latitude
    rename_column :offices, :y_coordinate, :longitude
  end

  def self.down
    rename_column :offices, :latitude, :x_coordinate
    rename_column :offices, :longitude, :y_coordinate
  end
end
