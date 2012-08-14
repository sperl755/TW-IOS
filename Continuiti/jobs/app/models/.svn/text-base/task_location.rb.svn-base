class TaskLocation < ActiveRecord::Base
  
  belongs_to :job
  #, :validate => true
  belongs_to :country
  #validates_presence_of :task_location_type_id

   #validates_associated :job
  #validates_presence_of  :job_id, :address_name, :city, :state, :zipcode, :country_id, :phone, :contact_name
end


# == Schema Information
#
# Table name: task_locations
#
#  id                    :integer(4)      not null, primary key
#  job_id                :integer(4)
#  address_name          :string(255)
#  address1              :string(255)
#  address2              :string(255)
#  city                  :string(255)
#  state                 :string(255)
#  zipcode               :integer(4)
#  country_id            :integer(4)
#  phone                 :string(255)
#  contact_name          :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  task_location_type_id :integer(4)      default(0)
#

