class Category < ActiveRecord::Base
  has_many :posts, :order => "published_at desc"
  has_many :jobs #has_and_belongs_to_many
  
  def to_param
    id.to_s << "-" << (name ? name.parameterize : '' )
  end
  
  def slug
    name.parameterize.downcase
  end

  def self.get(name)
    self.find_by_name(name.to_s.humanize)
  end
  
  def display_new_post_text
    new_post_text
  end
  
  def self.categories(type,active=1)
    return nil if type.blank?
    Category.find(:all,:conditions=>['ctype=? and active=?',type,active])
  end
end


# == Schema Information
#
# Table name: categories
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  tips          :text
#  new_post_text :string(255)
#  nav_text      :string(255)
#  ctype         :string(255)
#  active        :boolean(1)      default(FALSE)
#

