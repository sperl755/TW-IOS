require 'sunspot_rails'
require 'rubygems'
require 'google/geo'
class Location < ActiveRecord::Base
#  searchable do
#    text :city
#  end

  searchable do
    text :city
    location :coordinates
  end

  before_save :get_coordinates
  
  belongs_to :company
  belongs_to :country
  has_and_belongs_to_many :jobs
  has_and_belongs_to_many :companies
  
  attr_accessor :should_destroy
  def should_destroy?
    should_destroy.to_i == 1
  end

  def coordinates
    Sunspot::Util::Coordinates.new(self.latitude,self.longitude)
  end

  def coordinates=(sunspot_util_coordinates)
    self.lat,self.lng = [sunspot_util_coordinates.latitude, sunspot_util_coordinates.longitude]
  end

  def get_coordinates
    location = ''
    location = self.address1 + ', ' unless(self.address1.blank?)
    location += self.zip + ', ' unless(self.zip.blank?)
    location += self.city + ', ' unless(self.city.blank?)
    location += self.state + ', ' unless(self.state.blank?)
    location += self.country.name + ', ' unless self.country_id.blank?
    location.chop!
    location.chop!
#    puts location
    gg = Google::Geo.new(YAML.load_file("#{RAILS_ROOT}/config/gmaps_api_key.yml")[ENV['RAILS_ENV']])
    loc = gg.locate location
    self.latitude = loc.first.latitude
    self.longitude= loc.first.longitude
    
  end

end

# == Schema Information
#
# Table name: locations
#
#  id            :integer(4)      not null, primary key
#  user_id       :integer(4)
#  location_name :string(255)
#  telephone     :string(255)
#  address1      :string(255)
#  address2      :string(255)
#  city          :string(255)
#  state         :string(255)
#  zip           :integer(4)
#  latitude      :string(255)
#  longitude     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

