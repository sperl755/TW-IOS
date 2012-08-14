require 'rubygems'
require 'google/geo'
class Office < ActiveRecord::Base
  before_save :get_coordinates
  
  belongs_to :company

  attr_accessor :should_destroy
  def should_destroy?
    should_destroy.to_i == 1
  end
  
  def get_coordinates
    location = ''
    location = self.address1 + ', ' unless(self.address1.blank?)
    #    location += self.address + ', ' unless(self.address.blank?)
    location += self.zip + ', ' unless(self.zip.blank?)
    location += self.city + ', ' unless(self.city.blank?)
    location += self.state + ', ' unless(self.state.blank?)
    location += self.country + ', ' unless(self.country.blank?)
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
# Table name: offices
#
#  id          :integer(4)      not null, primary key
#  company_id  :integer(4)
#  office_name :string(255)
#  telephone   :string(255)
#  email       :string(255)
#  address1    :string(255)
#  address2    :string(255)
#  city        :string(255)
#  state       :string(255)
#  country     :string(255)
#  zip         :string(255)
#  latitude    :string(255)
#  longitude   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

