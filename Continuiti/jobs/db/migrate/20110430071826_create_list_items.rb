class CreateListItems < ActiveRecord::Migration
  def self.up
    create_table :list_items do |t|
      t.string :name
      t.references :list

      t.timestamps
    end
  end

  def self.down
    drop_table :list_items
  end
end