class CreateOffices < ActiveRecord::Migration
  def self.up
    create_table :offices do |t|
      t.integer :company_id
      t.string :office_name
      t.string :telephone
      t.string :email
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :x_coordinate
      t.string :y_coordinate

      t.timestamps
    end
  end

  def self.down
    drop_table :offices
  end
end
