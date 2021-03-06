class CreateEducations < ActiveRecord::Migration
  def self.up
    create_table :educations do |t|
      t.string :country
      t.string :organization
      t.string :degree
      t.string :major
      t.string :from_month
      t.integer :from_year
      t.string :end_month
      t.integer :end_year
      t.text :description
      t.date :from_date
      t.date :end_date
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :educations
  end
end
