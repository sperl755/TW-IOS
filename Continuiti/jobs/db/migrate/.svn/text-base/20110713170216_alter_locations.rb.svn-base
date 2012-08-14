class AlterLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :country_id, :integer
    add_column :locations, :contact_name, :string
    rename_column :locations, :telephone, :phone
    change_column :locations, :latitude, :decimal, :precision => 15, :scale => 10
    change_column :locations, :longitude, :decimal, :precision => 15, :scale => 10
    change_column :locations, :zip, :string
  end

  def self.down
    remove_column :locations, :country_id
    remove_column :locations, :contact_name
    rename_column :locations, :phone, :telephone
    change_column :locations, :latitude, :string
    change_column :locations, :longitude, :string
    change_column :locations, :zip, :integer
  end
end
