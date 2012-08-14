class CreateExperienceFunctionalAreas < ActiveRecord::Migration
  def self.up
    create_table :experience_functional_areas do |t|
      t.string :name
      t.timestamps
    end
    remove_column :experiences, :functional_area
    add_column :experiences, :functional_area_id, :integer
  end

  def self.down
    drop_table :experience_functional_areas
    remove_column :experiences, :functional_area_id
    add_column :experiences, :functional_area, :string
  end
end
