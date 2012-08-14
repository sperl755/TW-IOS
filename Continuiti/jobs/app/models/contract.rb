class Contract < ActiveRecord::Base
  belongs_to :application
  belongs_to :user
  belongs_to :job
  belongs_to :contractor, :class_name => 'User', :foreign_key => 'contractor_id'
  attr_accessor :feedback_type
  
  ajaxful_rateable :dimensions => [:skills, :quality, :availability, :deadlines, :communication, :cooperation, :actual_work_matched, :professionalism], :allow_update => true

  validates_presence_of :end_contractor_comment, :if => Proc.new { |contract|  contract.feedback_type=='contractor'}
  validates_inclusion_of :work_again_with_employer, :in => [true, false], :if => Proc.new { |contract|  contract.feedback_type=='contractor'}
  validates_presence_of :end_employer_comment, :if => Proc.new { |contract| contract.feedback_type=='employer'}
  validates_inclusion_of :work_again_with_contractor, :in => [true, false], :if => Proc.new { |contract|  contract.feedback_type=='employer'}
  #validate :validate

  def validate
    if feedback_type == "contractor"
      count = Rate.count_rating(contractor_id,id,"Contract")
      errors.add_to_base("Feedback is not completed.") if count != 5
    else
      count = Rate.count_rating(user_id,id,"Contract")
      errors.add_to_base("Feedback is not completed.") if count != 6
    end
  end
end
