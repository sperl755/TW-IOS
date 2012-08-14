class Country < ActiveRecord::Base
	attr_accessor :user
#  	attr_accessor :user
  has_many :metro_areas
  has_many :states
  has_many :jobs
  has_many :locations
  
  def self.get(name)
    case name
      when :us
        c = 'United States'
    end
    self.find_by_name(c)
  end
  
  def self.find_countries_with_metros
    MetroArea.find(:all, :include => :country).collect{ |m| m.country }.sort_by{ |c| c.name }.uniq
  end
  
  def states
    State.find(:all, :include => :metro_areas, :conditions => ["metro_areas.id in (?)", metro_area_ids ]).uniq
  end
  
  def metro_area_ids
    metro_areas.map{|m| m.id }
  end
  

end

# == Schema Information
#
# Table name: countries
#
#  id   :integer(4)      not null, primary key
#  name :string(255)
#

