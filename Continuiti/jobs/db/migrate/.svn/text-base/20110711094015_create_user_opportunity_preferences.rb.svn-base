class CreateUserOpportunityPreferences < ActiveRecord::Migration
  def self.up
    create_table :user_opportunity_preferences do |t|
      t.integer :user_id
      t.integer :opportunity_preference_id

      t.timestamps
    end
    add_index(:user_opportunity_preferences, [:user_id, :opportunity_preference_id], :name => "uop_idx")
  end

  def self.down
    drop_table :user_opportunity_preferences
  end
end
