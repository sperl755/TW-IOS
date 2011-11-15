class ChagedExperienceCountryToCountryId < ActiveRecord::Migration
  def self.up
    remove_column :experiences, :country
    add_column :experiences, :country_id, :integer
  end

  def self.down
    remove_column :experiences, :country_id
    add_column :experiences, :country, :string
  end
end