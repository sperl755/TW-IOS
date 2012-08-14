class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.integer :user_id, :null=>false
      t.integer :job_id, :null=>false
      t.integer :application_id, :null=>false
      t.boolean :status

      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
