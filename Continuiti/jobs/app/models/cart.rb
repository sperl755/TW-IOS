class Cart < ActiveRecord::Base
  has_many :cart_items, :dependent => :destroy
  has_many :jobs, :through => :cart_items

  has_one :order

  def total_price
    cart_items.to_a.sum(&:full_price)
  end
end
