class AddJobStatus < ActiveRecord::Migration
  def self.up
    add_column :jobs, :status, :integer, :limit => 1, :default => 1
    add_column :jobs, :visible_status, :integer, :limit => 1, :default => 0
    rename_column :jobs, :job_title, :title
    rename_column :jobs, :job_detail_description, :description
    rename_column :jobs, :job_detail_private, :private_description
    rename_column :jobs, :job_skills, :skills

  end

  def self.down
    remove_column :jobs, :status
    remove_column :jobs, :visible_status
    rename_column :jobs, :title, :job_title
    rename_column :jobs, :description, :job_detail_description
    rename_column :jobs, :private_description, :job_detail_private
    rename_column :jobs, :skills, :job_skills
  end
end
