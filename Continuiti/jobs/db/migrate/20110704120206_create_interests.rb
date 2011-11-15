class CreateInterests < ActiveRecord::Migration
  def self.up
    create_table :interests do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    add_index(:interests, :user_id)
  end

  def self.down
    drop_table :interests
  end
end
