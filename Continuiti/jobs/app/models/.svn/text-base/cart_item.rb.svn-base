class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :job

  def full_price
    unit_price * quantity
  end
end
