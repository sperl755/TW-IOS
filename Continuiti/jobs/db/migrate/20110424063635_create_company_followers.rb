class CreateCompanyFollowers < ActiveRecord::Migration
  def self.up
    create_table :company_followers do |t|
      t.integer :company_id
      t.integer :follower_id

      t.timestamps
    end
  end

  def self.down
    drop_table :company_followers
  end
end
