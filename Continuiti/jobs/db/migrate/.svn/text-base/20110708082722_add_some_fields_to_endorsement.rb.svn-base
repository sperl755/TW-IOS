class AddSomeFieldsToEndorsement < ActiveRecord::Migration
  def self.up
    add_column :endorsements, :job_title, :string
    add_column :endorsements, :company_name, :string
    add_column :endorsements, :relation_type, :string
    add_column :endorsements, :years_relation, :string
  end

  def self.down
    remove_column :endorsements, :job_title
    remove_column :endorsements, :company_name
    remove_column :endorsements, :relation_type
    remove_column :endorsements, :years_relation
  end
end
