class CreateApplications < ActiveRecord::Migration
  def self.up
    create_table :applications do |t|
      t.integer :job_id
      t.integer :user_id
      t.text :cover_letter
      t.string :file_file_name
      t.string :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at
      t.integer :status, :default=>1, :limit => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :applications
  end
end
