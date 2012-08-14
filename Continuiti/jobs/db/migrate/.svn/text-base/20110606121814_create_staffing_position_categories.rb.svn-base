class CreateStaffingPositionCategories < ActiveRecord::Migration
  def self.up
    create_table :staffing_position_categories do |t|
      t.string :title
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :staffing_position_categories
  end
end
