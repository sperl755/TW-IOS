class ChangeTitleToSkillIdOnUserSkills < ActiveRecord::Migration
  def self.up
    change_column :user_skills, :title, :integer
    rename_column :user_skills, :title, :skill_id
    add_index :user_skills, :skill_id
  end

  def self.down
    change_column :user_skills, :skill_id, :string
    rename_column :user_skills, :skill_id, :title
    remove_index :user_skills, :skill_id
  end
end
