class ChangeSomeFieldsOnUserSkill < ActiveRecord::Migration
  def self.up
    change_column :user_skills, :from_date, :integer
    rename_column :user_skills, :from_date, :month_period
    change_column :user_skills, :until_date, :integer
    rename_column :user_skills, :until_date, :year_period
  end

  def self.down
    change_column :user_skills, :month_period, :date
    rename_column :user_skills, :month_period, :from_date
    change_column :user_skills, :year_period, :date
    rename_column :user_skills, :year_period, :until_date
  end
end
