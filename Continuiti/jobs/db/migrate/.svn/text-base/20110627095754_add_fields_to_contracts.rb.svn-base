class AddFieldsToContracts < ActiveRecord::Migration
  def self.up
    add_column :contracts, :title, :string
    add_column :contracts, :start_datetime, :datetime
    add_column :contracts, :end_datetime, :datetime
    add_column :contracts, :end_contract_reason, :integer
    add_column :contracts, :ended_by, :integer
    add_column :contracts, :end_employer_comment, :text
    add_column :contracts, :end_contractor_comment, :text
  end

  def self.down
    remove_column :contracts, :title
    remove_column :contracts, :start_datetime
    remove_column :contracts, :end_datetime
    remove_column :contracts, :end_contract_reason
    remove_column :contracts, :ended_by
    remove_column :contracts, :end_employer_comment
    remove_column :contracts, :end_contractor_comment
  end
end
