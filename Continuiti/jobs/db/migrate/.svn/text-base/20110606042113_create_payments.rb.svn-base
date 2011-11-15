class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :payer_id
      t.integer :receiver_id
      t.integer :job_id

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
