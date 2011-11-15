require 'sunspot_rails'

class Company < ActiveRecord::Base
  belongs_to :user

  has_one :company_photo

  has_many :company_followers, :dependent => :destroy
  has_many :followers, :through => :company_followers
  has_and_belongs_to_many :locations
  
  has_many :offices
  has_many :industries
  #  attr_protected :user_id
  attr_accessible :name, :user_id, :company_url, :description, :mission_philosophy, :core_values, :what_we_look_for, :company_page_name,
    :company_photo_attributes, :office_attributes
  
  validates_presence_of :name, :company_page_name
  validates_uniqueness_of :company_page_name
  
  accepts_nested_attributes_for :company_photo, :allow_destroy => true

  searchable do
    text :name, :default_boost => 2
    text :description
  end
  
#  after_update :save_offices
  def office_attributes=(office_attributes)
    office_attributes.each do |attributes|
      #      offices.build(attributes)
      if attributes[:id].blank?
        self.offices.build(attributes)
      else
        office = offices.detect{ |o| o.id = attributes[:id].to_i}
        office.attributes = attributes
        if office.should_destroy?
          office.destroy
        else
          office.save
        end
      end
    end
  end

  def save_offices
    offices.each do |o|
      if o.should_destroy?
        o.destroy
      else
        o.save(false)
      end

    end
  end

  def company_photo_url(size = nil)
    if company_photo
      company_photo.public_filename(size)
    else
      case size
      when :thumb
        AppConfig.photo['missing_thumb']
      else
        AppConfig.photo['missing_medium']
      end
    end
  end

end






# == Schema Information
#
# Table name: companies
#
#  id                 :integer(4)      not null, primary key
#  user_id            :integer(4)
#  name               :string(255)
#  company_url        :string(255)
#  description        :text
#  mission_philosophy :text
#  core_values        :text
#  what_we_look_for   :text
#  company_page_name  :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

