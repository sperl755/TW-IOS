class CreateTaskLocations < ActiveRecord::Migration
  def self.up
    create_table :task_locations do |t|
      t.integer :job_id
      t.string :address_name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.integer :zipcode
      t.string :country
      t.string :phone
      t.string :contact_name

      t.timestamps
    end
  end

  def self.down
    drop_table :task_locations
  end
end
