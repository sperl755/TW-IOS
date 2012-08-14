class CreateApis < ActiveRecord::Migration
  def self.up
    create_table :apis do |t|
      t.integer :user_id
      t.string :key

      t.timestamps
    end
  end

  def self.down
    drop_table :apis
  end
end
