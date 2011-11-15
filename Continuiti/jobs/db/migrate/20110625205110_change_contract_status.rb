class ChangeContractStatus < ActiveRecord::Migration
  def self.up
    change_column :contracts, :status, :integer, :limit => 1
    add_column :contracts, :contractor_id, :integer
  end

  def self.down
    change_column :contracts, :status, :boolean
    remove_column :contracts, :contractor_id
  end
end
