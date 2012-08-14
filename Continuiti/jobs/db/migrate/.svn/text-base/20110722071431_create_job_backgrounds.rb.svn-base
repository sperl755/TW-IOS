class CreateJobBackgrounds < ActiveRecord::Migration
   def self.up
    create_table :job_backgrounds, {:id => false} do |t|
      t.integer :job_id
      t.integer :background_id
      t.string :details

      t.timestamps
    end
  end

  def self.down
    drop_table :job_backgrounds
  end
end
