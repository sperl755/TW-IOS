class Education < ActiveRecord::Base
  belongs_to :user
  #  belongs_to :degree
  
  #validates_presence_of :organization, :message=>"Enter School/University"
  #validates_presence_of :major, :message=>"Enter field(s) of study"
  validates_presence_of :degree
  #validates_presence_of :from_year, :end_year, :message=>"Enter dates attended"
  validates_format_of :url, :with => /^((http|https):\/\/)*[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, :unless => Proc.new{|education| education.url.blank?}
  before_create :validate_url, :unless => Proc.new{|education| education.url.blank?}
  before_update :validate_url, :unless => Proc.new{|education| education.url.blank?}

  def validate
    #    if degree.blank?
    #      errors.add_to_base("Degree can't blank")
    #    end
    
    if organization.blank?
      errors.add_to_base("School/University can't blank")
    end
    
    if major.blank?
      errors.add_to_base("Field(s) of study can't blank")
    end
    
    if from_year.blank? || end_year.blank?
      errors.add_to_base("Dates attended can't blank")
    end
    
    if !from_year.blank? && !end_year.blank? && from_year.to_i > end_year.to_i
      errors.add_to_base( "Dates attended is not valid ")
    end
    
  end

  def validate_url
    unvalidate_url = self.url.downcase
    self.url = if unvalidate_url.index("http://").eql?(nil) or unvalidate_url.index("http://") > 0
      if unvalidate_url.index("https://").eql?(nil) or unvalidate_url.index("https://") > 0
        "http://" + unvalidate_url
      else
        unvalidate_url
      end
    else
      unvalidate_url
    end
  end
end




# == Schema Information
#
# Table name: educations
#
#  id           :integer(4)      not null, primary key
#  country      :string(255)
#  organization :string(255)
#  degree_id    :integer(4)
#  major        :string(255)
#  from_year    :integer(4)
#  end_year     :integer(4)
#  description  :text
#  from_date    :date
#  end_date     :date
#  user_id      :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#  url          :string(255)
#  activities   :text
#

