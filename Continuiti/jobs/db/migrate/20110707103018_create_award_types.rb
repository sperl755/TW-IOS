class CreateAwardTypes < ActiveRecord::Migration
  def self.up
    create_table :award_types do |t|
      t.string :name

      t.timestamps
    end
    AwardType.create([{:name => "Type 1"}, {:name => "Type 2"}, {:name => "Type 3"}, {:name => "Type 4"}])
  end

  def self.down
    drop_table :award_types
  end
end
