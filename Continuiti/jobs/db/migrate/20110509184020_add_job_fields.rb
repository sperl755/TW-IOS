class AddJobFields < ActiveRecord::Migration
  def self.up
    add_column :jobs, :category_id, :integer
    add_column :jobs, :industry_id, :integer
    add_column :jobs, :company, :string
    add_column :jobs, :expense_required, :integer
    add_column :jobs, :task_location_type_id, :integer
  end

  def self.down
    remove_column :jobs, :category_id
    remove_column :jobs, :industry_id
    remove_column :jobs, :company
    remove_column :jobs, :expense_required
    remove_column :jobs, :task_location_type_id
  end
end
