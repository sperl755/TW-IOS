class CreateCertifications < ActiveRecord::Migration
  def self.up
    create_table :certifications do |t|
      t.string :title
      t.date :award_date
      t.integer :user_id

      t.timestamps
    end
    add_index(:certifications, :user_id)
  end

  def self.down
    drop_table :certifications
  end
end
