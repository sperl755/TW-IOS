class CreateTimeUnits < ActiveRecord::Migration
  def self.up
    create_table :time_units do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :time_units
  end
end
