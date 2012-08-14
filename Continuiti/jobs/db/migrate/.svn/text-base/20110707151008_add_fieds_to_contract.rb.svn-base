class AddFiedsToContract < ActiveRecord::Migration
  def self.up
    add_column :contracts, :work_again_with_employer, :boolean
    add_column :contracts, :work_again_with_contractor, :boolean
  end

  def self.down
    remove_column :contracts, :work_again_with_employer
    remove_column :contracts, :work_again_with_contractor
  end
end
