class CreateRates < ActiveRecord::Migration
  def self.up
    create_table :rates do |t|
      t.belongs_to :rater
      t.belongs_to :rateable, :polymorphic => true
      t.integer :stars, :null => false
      t.string :dimension
      t.timestamps
    end
    add_column :users, :rating_average, :decimal, :default => 0, :precision => 6, :scale => 2
    add_index :rates, :rater_id
    add_index :rates, [:rateable_id, :rateable_type]
  end

  def self.down
    drop_table :rates
    remove_column :users, :rating_average
  end
end
