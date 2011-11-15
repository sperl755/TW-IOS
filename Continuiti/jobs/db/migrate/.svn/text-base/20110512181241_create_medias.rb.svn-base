class CreateMedias < ActiveRecord::Migration
  def self.up
    create_table :medias do |t|
      t.string    :title
      t.text      :description
      t.text      :notes
      t.string    :media_file_name
      t.string    :media_content_type
      t.integer   :media_file_size
      t.datetime  :media_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :user_files
  end
end
