class AddColumsPayableIdAndPayableTypeToPayment < ActiveRecord::Migration
  def self.up
    add_column :payments, :payable_type, :string
    rename_column :payments, :job_id, :payable_id
    add_column :payments, :amount, :float
  end

  def self.down
    remove_column :payments, :payable_type
    rename_column :payments, :payable_id, :job_id
    remove_column :payments, :amount
  end
end
