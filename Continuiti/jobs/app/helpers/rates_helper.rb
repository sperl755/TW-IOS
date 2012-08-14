module RatesHelper
  def average_rating(user_id, rateable_id=nil, rateable_type=nil)
    Rate.average_rating(user_id, rateable_id, rateable_type)
  end

  def average_type_rating(user_id)
    return avg_ratings = Rate.average_type_rating(user_id)
  end
end
