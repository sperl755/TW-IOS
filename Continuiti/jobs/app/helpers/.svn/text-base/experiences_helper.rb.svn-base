module ExperiencesHelper
  
  def render_country_select(model_variable)
    model_variable.select(:country_id, '<option></option>'+options_from_collection_for_select(Country.find_countries_with_metros, "id", "name"), {:style => "width:100px"})
  end
  
end
