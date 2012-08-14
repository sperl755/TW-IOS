class Bid < ActiveRecord::Base
  belongs_to :application

  attr_accessor :total_payment

  validates_numericality_of :paid_amount, :allow_blank => false, :message=>' is not valid'
  #validates_presence_of :total_payment
end

# == Schema Information
#
# Table name: bids
#
#  id             :integer(4)      not null, primary key
#  job_id         :integer(4)
#  application_id :integer(4)
#  paid_amount    :float
#  fees           :float
#  created_at     :datetime
#  updated_at     :datetime
#

