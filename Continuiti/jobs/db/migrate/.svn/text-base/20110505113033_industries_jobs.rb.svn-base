class IndustriesJobs < ActiveRecord::Migration
  def self.up
    create_table 'industries_jobs', :id => false do |t|
       t.column :industry_id, :integer
       t.column :job_id, :integer
    end
  end

  def self.down
    drop_table :industries_jobs
  end
end
