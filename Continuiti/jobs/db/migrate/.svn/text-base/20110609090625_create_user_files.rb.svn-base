class CreateUserFiles < ActiveRecord::Migration
  def self.up
    create_table :user_files do |t|
      t.string :data_file_name
      t.string :data_content_type
      t.integer :data_file_size
      t.references :attachable, :polymorphic => true

      t.timestamps
    end
    add_index :user_files, [:attachable_id, :attachable_type]
    
  end

  def self.down
    drop_table :user_files
  end
end
