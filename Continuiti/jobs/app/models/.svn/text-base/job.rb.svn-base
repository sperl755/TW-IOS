require 'sunspot_rails'

class Job < ActiveRecord::Base

  searchable do
    text :title, :default_boost => 2
    text :description
#    text :locations do
#      locations.map { |location| location.city}
#    end
    Location.all.each { |loc|   # TODO: I need to change here..
      location :coordinates do
          Sunspot::Util::Coordinates.new(loc.latitude, loc.longitude)
      end
    }
    integer :location_ids, :multiple => true  #, :references => Location

  end

  after_update :save_locations
  #after_validation :validate_location

  belongs_to :user
  belongs_to :jobtype
  belongs_to :cost_method
  belongs_to :staffing_position_category
  belongs_to :staffing_position_type
  #has_many :task_locations
  has_and_belongs_to_many :locations
  belongs_to :time_unit
  has_many :applications
  has_many :contracts
  belongs_to :category #has_and_belongs_to_many :categories
  belongs_to :industry #has_and_belongs_to_many :industries

  has_many :cart_items
  has_many :carts, :through => :cart_items

  has_many :payments, :as => :payable

#  has_many :earnings, :as => :earnable
  
  ############################## attachment #####################
  has_many :user_files, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :user_files
  Max_Attachments = 2
  Max_Attachment_Size = 5000000
  validate :validate_attachments
  def validate_attachments
    #errors.add_to_base("Too many attachments - maximum is #{UserFile::Max_Attachments}") if user_files.length > UserFile::Max_Attachments
    user_files.each {|a| errors.add_to_base("#{a.name} is over #{Job::Max_Attachment_Size/1.megabyte}MB") if !a.data_file_name.blank? && a.file_size > Job::Max_Attachment_Size}
  end  
  ############################## attachment #####################
  
  #validates_associated :task_locations, :if => Proc.new {|job| job.task_location_type_id.to_i == 2}
  validates_presence_of :task_start_date, :task_start_time, :task_end_date, :task_end_time, :if => Proc.new { |job| job.task_duration_type && !job.jobtype.nil? && !job.jobtype.title.include?("Staffing") }

  validates_presence_of :task_on_date, :task_on_time, :if => Proc.new { |job| !job.task_duration_type.nil? && !job.task_duration_type}
  validates_presence_of :task_on_date, :if => Proc.new { |job| job.task_duration_type.nil?}
  
  validates_presence_of :jobtype_id, :title, :description, :task_location_type_id
  validates_presence_of :title, :private_description, :cost_method_id, :vehicle, :skills , :unless => Proc.new { |job| job.jobtype.title.include?("Staffing") }
  validates_presence_of :fixed_cost_amount, :if => Proc.new { |job|  !job.nil? && !job.cost_method.nil? && !job.cost_method.title.blank? && job.cost_method.title.include?('Fixed') && !job.jobtype.title.include?("Staffing")}
  validates_presence_of :time_unit_id,:cost_per_time_unit,:average_expected_cost,:average_expected_time, :if => Proc.new { |job| !job.nil? && !job.cost_method.nil? && !job.cost_method.title.blank? && job.cost_method.title.include?('Hourly') && !job.jobtype.title.include?("Staffing")}
  validates_presence_of :average_expected_cost,:average_expected_time,:custom_quote_factors, :if => Proc.new { |job| !job.nil? && !job.cost_method.nil? && !job.cost_method.title.blank? && job.cost_method.title.include?('Custom') && !job.jobtype.title.include?("Staffing")}

  validates_numericality_of :average_expected_time,  :only_integer => true, :if => Proc.new { |job| !job.nil? && !job.cost_method.nil? && !job.cost_method.title.blank? && job.cost_method.title.include?('Hourly') && !job.jobtype.title.include?("Staffing")}
  # validates_presence_of :average_expected_time, :if => Proc.new { |job| !job.nil? && !job.cost_method.nil? && !job.cost_method.title.blank? && job.cost_method.title.include?('Custom') }

  validates_numericality_of :cost_per_time_unit, :fixed_cost_amount, :only_integer => true, :allow_blank => true, :unless => Proc.new { |job| job.jobtype.title.include?("Staffing") }
  validates_length_of :skills, :maximum=>255, :unless => Proc.new { |job| job.jobtype.title.include?("Staffing") }

  validates_presence_of :company_description,:requirement_list,:compensation,:duration,:hours_per_week,:staffing_position_type_id,:staffing_position_category_id,:industry_id, :if => Proc.new { |job| job.jobtype.title.include?("Staffing") }

  def validate
    errors.add_to_base("Job title can't blank") if title == APP_CONFIG['job_title_default_text']
    errors.add_to_base("Description can't blank") if description == APP_CONFIG['job_detail_description_default_text']
    errors.add_to_base("Private notes can't blank") if private_description == APP_CONFIG['job_detail_private_default_text']
    errors.add_to_base("Vehicle can't blank") if vehicle == APP_CONFIG['job_vehicle_default_text']
    errors.add_to_base("Requirement list can't blank") if requirement_list == APP_CONFIG['requirement_list_default_text']
    errors.add_to_base("Company description can't blank") if company_description == APP_CONFIG['company_description_default_text']
    
    if !cost_method.nil? && !cost_method.title.blank? && cost_method.title.include?('Custom') && !average_expected_time.blank?
      arr = %w{hour week month year}
      flag = 0
      aet = average_expected_time.downcase
      arr.each{ |v|
        flag = 1 if aet.include?(v)
      }
      errors.add_to_base("Expected cost should be valid") if flag == 0
    end
     validate_location
  end

  def validate_location
    if task_location_type_id > 1
      err = 0
      err = 1 if locations.size<=0
      locations.each { |tl|
        if tl.city.blank? || tl.location_name.blank? || tl.zip.blank? || tl.state.blank? || tl.country_id.blank? || tl.phone.blank? || tl.contact_name.blank?
          err = 1
        end
      }
      errors.add_to_base("Please enter valid address.") if err==1

    end
  end

  # For Updating Existing Task Location
  def existing_location_attributes=(existing_location_attributes)
    locations.reject(&:new_record?).each do |location|
      location_attributes = existing_location_attributes[location.id.to_s]
      if location_attributes
        location.attributes = location_attributes
      else
        locations.delete(location)
      end
    end
  end

  # For Creating New Task Locations
  def new_location_attributes=(new_location_attributes)
    new_location_attributes.each do |location_attribute|
      locations.build(location_attribute)
    end
  end

  def save_locations
    locations.each do |location|
       if location.readonly?
         loc = Location.find_by_id(location.id)
         loc_hash = Hash.new
         loc_hash['location_name'] = location.location_name
         loc_hash['phone'] = location.phone
         loc_hash['address1'] = location.address1
         loc_hash['address2'] = location.address2
         loc_hash['city'] = location.city
         loc_hash['state'] = location.state
         loc_hash['zip'] = location.zip
         loc_hash['country_id'] = location.country_id
         loc_hash['contact_name'] = location.contact_name
         loc.update_attributes(loc_hash)
       else
         location.save(false)
       end
    end
  end

  def required_job_investment
    if self.cost_method.title.include?('Fixed')
      required_investment = self.fixed_cost_amount.to_f - self.total_paid_amount
    elsif self.cost_method.title.include?('Hourly')
      required_investment = self.average_expected_cost.to_f - self.total_paid_amount
    elsif self.cost_method.title.include?('Custom')
      required_investment = self.average_expected_cost.to_f - self.total_paid_amount
    else
      required_investment = self.total_cost_calculated.to_f - self.total_paid_amount
    end
    required_investment
  end
end













# == Schema Information
#
# Table name: jobs
#
#  id                                :integer(4)      not null, primary key
#  jobtype_id                        :integer(4)
#  title                             :string(255)
#  description                       :string(255)
#  private_description               :string(255)
#  task_start_time_date              :string(255)
#  task_completed_by_time_date       :string(255)
#  your_time_estimate                :string(255)
#  your_cost_estimate_per_hour       :float
#  your_estimated_expense_to_do_task :float
#  total_cost_calculated             :string(255)
#  vehicle_id                        :integer(4)
#  action_chosen                     :string(255)
#  make_template                     :boolean(1)
#  created_at                        :datetime
#  updated_at                        :datetime
#  cost_method_id                    :integer(4)      default(0)
#  time_unit_id                      :integer(4)
#  cost_per_time_unit                :string(255)
#  fixed_cost_amount                 :string(255)
#  average_expected_cost             :string(255)
#  average_expected_time             :string(255)
#  custom_quote_factors              :string(255)
#  skills                            :string(255)
#  user_id                           :integer(4)
#  category_id                       :integer(4)
#  industry_id                       :integer(4)
#  company                           :string(255)
#  expense_required                  :integer(4)
#  task_location_type_id             :integer(4)
#  status                            :integer(1)      default(1)
#  visible_status                    :integer(1)      default(0)
#
