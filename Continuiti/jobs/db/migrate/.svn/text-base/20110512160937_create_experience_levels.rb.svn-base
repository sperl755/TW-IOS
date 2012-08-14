class CreateExperienceLevels < ActiveRecord::Migration
  def self.up
    create_table :experience_levels do |t|
      t.string :name
      t.timestamps
    end
    remove_column :experiences, :career_level
    add_column :experiences, :career_level_id, :integer
  end

  def self.down
    drop_table :experience_levels
    remove_column :experiences, :career_level_id
    add_column :experiences, :career_level, :string
  end
end
