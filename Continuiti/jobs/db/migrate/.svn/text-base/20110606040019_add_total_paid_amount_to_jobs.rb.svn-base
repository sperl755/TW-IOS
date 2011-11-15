class AddTotalPaidAmountToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :total_paid_amount, :float, :default => 0.0
  end

  def self.down
    remove_column :jobs, :total_paid_amount
  end
end
