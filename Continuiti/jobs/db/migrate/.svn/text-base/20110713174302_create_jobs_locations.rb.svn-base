class CreateJobsLocations < ActiveRecord::Migration
  def self.up
    create_table :jobs_locations, {:id => false} do |t|
      t.integer :job_id
      t.integer :location_id

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs_locations
  end
end
