class UserFile < ActiveRecord::Base
  has_attached_file :data, :url => "/userfiles/:id", :path => ":rails_root/public/system/userfiles/:id/:basename.:extension"
  belongs_to :attachable, :polymorphic => true

  #Set number to the Max Attachments allowed for owner
  #Max_Attachments = 5
  #Max_Attachment_Size = 2.megabyte

  def url(*args)
    data.url(*args)
  end

  def name
    data_file_name
  end

  def content_type
    data_content_type
  end

  def file_size
    data_file_size
  end

end
