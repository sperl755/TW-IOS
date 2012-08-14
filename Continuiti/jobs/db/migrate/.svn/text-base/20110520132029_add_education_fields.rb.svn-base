class AddEducationFields < ActiveRecord::Migration
  def self.up
    add_column :educations, :activities, :text
    add_column :degrees, :active, :boolean
  end

  def self.down
    remove_column :educations, :activities
    remove_column :degrees, :active
  end
end
