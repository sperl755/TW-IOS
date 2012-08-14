module UserSkillsHelper
  def add_task_link(name, div_container_id, partial_file_name, object)
    link_to_function name do |page|
      page.insert_html :bottom, "#{div_container_id}", :partial => "#{partial_file_name}" , :object => object
    end
  end
end
