class CreateOpportunityPreferences < ActiveRecord::Migration
  def self.up
    create_table :opportunity_preferences do |t|
      t.string :name

      t.timestamps
    end
    OpportunityPreference.create([{:name => "On Demand Or Urgent Requests"}, {:name => "Part-Time Requests"},
        {:name => "Full-Time Requests"}, {:name => "A Few Hours Per Week"}, {:name => "Project Requests"},
        {:name => "Career Opportunities"}, {:name => "Expertise Requests"}, {:name => "Networking"}])
  end

  def self.down
    drop_table :opportunity_preferences
  end
end
