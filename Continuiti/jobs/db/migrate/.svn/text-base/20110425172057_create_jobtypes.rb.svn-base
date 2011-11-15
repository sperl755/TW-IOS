class CreateJobtypes < ActiveRecord::Migration
  def self.up
    create_table :jobtypes do |t|
      t.string :title
      t.string :description
      t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :jobtypes
  end
end
