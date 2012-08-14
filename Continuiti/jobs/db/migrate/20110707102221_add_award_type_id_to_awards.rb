class AddAwardTypeIdToAwards < ActiveRecord::Migration
  def self.up
    add_column :awards, :award_type_id, :integer
    add_index(:awards, :award_type_id)
  end

  def self.down
    remove_column :awards, :award_type_id
  end
end
