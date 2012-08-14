class CreateExperiences < ActiveRecord::Migration
  def self.up
    create_table :experiences do |t|
      t.string :company
      t.string :company_url
      t.string :industry
      t.string :functional_area
      t.string :country
      t.string :city
      t.string :title
      t.string :career_level
      t.string :from_month
      t.integer :from_year
      t.string :end_month
      t.integer :end_year
      t.boolean :current
      t.text :description
      t.date :from_date
      t.date :end_date
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :experiences
  end
end
