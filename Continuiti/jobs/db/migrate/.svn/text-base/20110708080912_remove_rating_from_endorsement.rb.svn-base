class RemoveRatingFromEndorsement < ActiveRecord::Migration
  def self.up
    remove_column :endorsements, :rating
  end

  def self.down
    add_column :endorsements, :rating, :integer
  end
end
