class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.string :name
      t.date :from_date
      t.date :until_date
      t.integer :user_id

      t.timestamps
    end
    add_index(:memberships, :user_id)
  end

  def self.down
    drop_table :memberships
  end
end
