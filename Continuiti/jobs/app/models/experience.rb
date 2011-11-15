class Experience < ActiveRecord::Base
  belongs_to :user
  belongs_to :experience_level, :foreign_key => :career_level_id
  belongs_to :experience_functional_area, :foreign_key => :functional_area_id 
  belongs_to :country
  
  validates_format_of :company_url, :with => /^((http|https):\/\/)*[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, :unless => Proc.new{|experience| experience.company_url.blank?}
  validates_presence_of :from_month, :from_year, :title, :company_name

  #validates_presence_of :end_month, :end_year, :if => Proc.new { |exp| !exp.current }
  before_create :validate_url, :unless => Proc.new{|experience| experience.company_url.blank?}
  before_update :validate_url, :unless => Proc.new{|experience| experience.company_url.blank?}
  
  def validate
    if !current && (end_month.blank? || end_year.blank?)
      errors.add_to_base("End date can't blank")
    elsif !current && ((Date.civil(end_year.to_i,end_month.to_i) - Date.civil(from_year.to_i,from_month.to_i)).to_i<0)
      errors.add_to_base("Enter time period.")
    else
      current_date = Time.now
      if current && ((Date.civil(current_date.strftime("%Y").to_i,current_date.strftime("%m").to_i) - Date.civil(from_year.to_i,from_month.to_i)).to_i < 0)
        errors.add_to_base("End year must equal or greater than start year.")
      end
    end
  end

  def validate_url
    unvalidate_company_url = self.company_url.downcase
    self.company_url = if unvalidate_company_url.index("http://").eql?(nil) or unvalidate_company_url.index("http://") > 0
      if unvalidate_company_url.index("https://").eql?(nil) or unvalidate_company_url.index("https://") > 0
        "http://" + unvalidate_company_url
      else
        unvalidate_company_url
      end
    else
      unvalidate_company_url
    end
  end

end




# == Schema Information
#
# Table name: experiences
#
#  id                 :integer(4)      not null, primary key
#  company_name       :string(255)
#  company_url        :string(255)
#  industry           :string(255)
#  city               :string(255)
#  title              :string(255)
#  from_month         :integer(4)
#  from_year          :integer(4)
#  end_month          :integer(4)
#  end_year           :integer(4)
#  current            :boolean(1)
#  description        :text
#  from_date          :date
#  end_date           :date
#  user_id            :integer(4)
#  created_at         :datetime
#  updated_at         :datetime
#  career_level_id    :integer(4)
#  functional_area_id :integer(4)
#  country_id         :integer(4)
#  company            :string(222)     not null
#

