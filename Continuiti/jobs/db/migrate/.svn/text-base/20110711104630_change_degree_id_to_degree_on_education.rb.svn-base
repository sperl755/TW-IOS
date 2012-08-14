class ChangeDegreeIdToDegreeOnEducation < ActiveRecord::Migration
  def self.up
    change_column :educations, :degree_id, :string
    rename_column :educations, :degree_id, :degree
  end

  def self.down
    change_column :educations, :degree, :integer
    rename_column :educations, :degree, :degree_id
  end
end
