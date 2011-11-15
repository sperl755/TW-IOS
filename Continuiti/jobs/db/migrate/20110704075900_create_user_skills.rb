class CreateUserSkills < ActiveRecord::Migration
  def self.up
    create_table :user_skills do |t|
      t.string :title
      t.text :description
      t.date :from_date
      t.date :until_date
      t.integer :user_id

      t.timestamps
    end
    add_index(:user_skills, :user_id)
  end

  def self.down
    drop_table :user_skills
  end
end
