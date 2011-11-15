class CreateUserDescriptions < ActiveRecord::Migration
  def self.up
    create_table :user_descriptions do |t|
      t.text :description
      t.integer :user_id

      t.timestamps
    end
    add_index(:user_descriptions, :user_id)
  end

  def self.down
    drop_table :user_descriptions
  end
end
