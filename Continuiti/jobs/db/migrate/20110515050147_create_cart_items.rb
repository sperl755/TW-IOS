class CreateCartItems < ActiveRecord::Migration
  def self.up
    create_table :cart_items do |t|
      t.integer  :job_id
      t.integer :cart_id
      t.float :unit_price
      t.integer :quantity, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :cart_items
  end
end
