class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.references :user
      t.string :name
      t.string :company_url
      t.text :description
      t.text :mission_philosophy
      t.text :core_values
      t.text :what_we_look_for
      t.string :company_page_name

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
