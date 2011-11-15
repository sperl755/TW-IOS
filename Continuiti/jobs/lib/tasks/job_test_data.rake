namespace :jobs do
  desc "Generating data for jobs"
  task :test_data => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE time_units")
    #TimeUnit.delete_all
    puts "Deleted time_units data..."
    TimeUnit.create(:name=>'Hours',:active=>1)
    TimeUnit.create(:name=>'Days',:active=>1)
    TimeUnit.create(:name=>'Weeks',:active=>1)
    TimeUnit.create(:name=>'Months',:active=>1)
    puts "Created data for time_units..."
    
    #if CostMethod.count <= 0
    ActiveRecord::Base.connection.execute("TRUNCATE cost_methods")
    #CostMethod.delete_all
    puts "Deleted cost_methods data..."
    CostMethod.create(:title=>'Fixed Price',:active=>1)
    CostMethod.create(:title=>'Time and Hourly',:active=>1)
   # CostMethod.create(:title=>'Custom Estimate Required',:active=>1)
    puts "Created data for cost_methods..."
    #end 
    
    ActiveRecord::Base.connection.execute("TRUNCATE vehicles")
    #Vehicle.delete_all
    puts "Deleted vehicles data..."
    Vehicle.create(:title=>'Not necessary as long as you can get to the job location.',:active=>1)
    Vehicle.create(:title=>'Yes, any type.',:active=>1)
    Vehicle.create(:title=>'Yes, a specific type and details are in my job description.',:active=>1)
    puts "Created data for vehicles..."
    
    #Industry.delete_all
    ActiveRecord::Base.connection.execute("TRUNCATE industries")
    puts "Deleted industries data..."
    Industry.create(:name=>'Service',:active=>1)
    Industry.create(:name=>'Manufacturing',:active=>1)
    Industry.create(:name=>'Software',:active=>1)
    Industry.create(:name=>'Banking',:active=>1)
    Industry.create(:name=>'Education',:active=>1)
    puts "Created data for industries..."
    
    ActiveRecord::Base.connection.execute("TRUNCATE jobtypes")
    #Jobtype.delete_all
    puts "Deleted jobtypes data..."
    Jobtype.create(:title=>'My services',:active=>1)
    Jobtype.create(:title=>'Tasks',:active=>1)
    Jobtype.create(:title=>'Full time job',:active=>1)
    Jobtype.create(:title=>'Staffing Position',:active=>1)
    puts "Created data for jobtypes..."


    ActiveRecord::Base.connection.execute("TRUNCATE staffing_position_types")
    puts "Deleted staffing_position_types data..."
    StaffingPositionType.create(:title=>'Temporary Contract',:active=>1)
    StaffingPositionType.create(:title=>'Permanent',:active=>1)
    StaffingPositionType.create(:title=>'Temporary to Permanent',:active=>1)
    puts "Created data for staffing_position_types..."

    #Industry.delete_all
    ActiveRecord::Base.connection.execute("TRUNCATE staffing_position_categories")
    puts "Deleted staffing_position_categories(function) data..."
    StaffingPositionCategory.create(:title=>'Sales',:active=>1)
    StaffingPositionCategory.create(:title=>'Customer Service',:active=>1)
    StaffingPositionCategory.create(:title=>'Software Engineer',:active=>1)
    StaffingPositionCategory.create(:title=>'Teacher',:active=>1)
    puts "Created data for staffing_position_categories(function)..."
    
    puts "All job data has generated."
  end
end