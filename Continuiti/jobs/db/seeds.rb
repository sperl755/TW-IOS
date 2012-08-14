# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
def conditionally_create(model, name)
  model.create(:name => name) unless model.find_by_name(name)
end

%w(
  Consulting
  Finance
  Accounting
  IT and Telecoms
).each do |name|
  conditionally_create ExperienceFunctionalArea, name
end

%w(
  Graduate
  Specialist
  Senior Specialist
  Project Manager
  Manager
  Team Leader
).each do |name|
  conditionally_create ExperienceLevel, name
end