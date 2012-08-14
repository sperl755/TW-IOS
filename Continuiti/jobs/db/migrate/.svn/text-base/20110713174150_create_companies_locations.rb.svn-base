class CreateCompaniesLocations < ActiveRecord::Migration
  def self.up
    create_table :companies_locations, {:id => false} do |t|
      t.integer :company_id
      t.integer :location_id

      t.timestamps
    end
  end

  def self.down
    drop_table :companies_locations
  end
end
