class AddMissingColumnsInOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :card_expires_on, :date
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :express_token, :string
    add_column :orders, :express_payer_id, :string
  end

  def self.down
    remove_column :orders, :card_expires_on
    remove_column :orders, :first_name
    remove_column :orders, :last_name
    remove_column :orders, :express_payer_id
    remove_column :orders, :express_token
  end
end
