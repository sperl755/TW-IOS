class CategoriesJobs < ActiveRecord::Migration
  def self.up
    create_table 'categories_jobs', :id => false do |t|
      t.column :category_id, :integer
      t.column :job_id, :integer
    end
  end

  def self.down
    drop_table :categories_jobs
  end
end
