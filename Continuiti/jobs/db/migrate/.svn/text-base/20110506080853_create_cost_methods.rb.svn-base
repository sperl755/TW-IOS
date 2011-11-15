class CreateCostMethods < ActiveRecord::Migration
  def self.up
    create_table :cost_methods do |t|
      t.string :title
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :cost_methods
  end
end
