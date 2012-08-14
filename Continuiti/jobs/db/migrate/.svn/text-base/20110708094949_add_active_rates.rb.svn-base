class AddActiveRates < ActiveRecord::Migration
  def self.up
    add_column :rates, :active, :boolean, :default => 0
  end

  def self.down
    remove_column :rates, :active
  end
end
