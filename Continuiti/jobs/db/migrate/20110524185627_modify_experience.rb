class ModifyExperience < ActiveRecord::Migration
  def self.up
    remove_column :educations, :from_month
    remove_column :educations, :end_month
    change_column :experiences, :from_month, :integer
    change_column :experiences, :end_month, :integer
  end

  def self.down
    add_column :educations, :from_month, :integer
    add_column :educations, :end_month, :integer
  end
end
