module JobsHelper

  def add_location_link
    link_to_function (image_tag 'right_arrow.gif',:border=>0)+" Add An Additional Location" do |page|
      page.insert_html :bottom, "locations", :partial => "location", :object => Location.new
    end
  end

end
