class CreateGeneralAvailabilities < ActiveRecord::Migration
  def self.up
    create_table :general_availabilities, :force => true do |t|
      t.string :name

      t.timestamps
    end
    GeneralAvailability.create([{:name => "Business Hours"}, {:name => "Weekday Evenings"},
        {:name => "Weekends"}, {:name => "24x7"}])
  end

  def self.down
    drop_table :general_availabilities
  end
end
