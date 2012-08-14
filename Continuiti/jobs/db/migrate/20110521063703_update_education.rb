class UpdateEducation < ActiveRecord::Migration
  def self.up
    rename_column :educations, :degree, :degree_id
    change_column :educations, :degree_id, :integer
    rename_column :experiences, :company, :company_name
  end

  def self.down
    rename_column :educations, :degree_id, :degree
    change_column :educations, :degree_id, :string
    rename_column :experiences, :company_name, :company
  end
end
