class CreateVehicles < ActiveRecord::Migration
  def self.up
    create_table :vehicles do |t|
      t.string :title
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :vehicles
  end
end
