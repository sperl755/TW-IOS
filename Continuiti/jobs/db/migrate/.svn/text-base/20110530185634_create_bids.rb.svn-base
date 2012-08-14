class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.integer :job_id
      t.integer :application_id
      t.float :paid_amount
      t.float :fees
      t.tinyint :type

      t.timestamps
    end
  end

  def self.down
    drop_table :bids
  end
end
