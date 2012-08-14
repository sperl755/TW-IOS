class CreateEndorsements < ActiveRecord::Migration
  def self.up
    create_table :endorsements do |t|
      t.text :description
      t.integer :rating
      t.integer :endorser_id
      t.integer :user_id

      t.timestamps
    end
    add_index(:endorsements, [:endorser_id, :user_id])
  end

  def self.down
    drop_table :endorsements
  end
end
