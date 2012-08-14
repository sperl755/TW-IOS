class GeneralAvailabilitiesController < ApplicationController
  def new
    @general_availabilities = GeneralAvailability.all(:conditions => "user_id IS NULL OR user_id = '#{current_user.id}'")
    if request.xhr?
      render :update do |page|
        page.replace_html "general_availability_container", :partial => "general_availabilities/new_general_availability"
      end
    end
  end

  def create
    unless params[:general_availability].blank?
      general_availability_values = []
      params[:general_availability].each do |key, val|
        general_availability_values << {:user_id => current_user.id, :general_availability_id => key}
      end
      UserGeneralAvailability.create(general_availability_values)

      current_user.reload
      @my_general_availabilities = current_user.user_general_availabilities
      if request.xhr?
        render :update do |page|
          page.replace_html "general_availability_container", :partial => "general_availabilities/general_availability_list"
        end
      end
    else
      if request.xhr?
        render :update do |page|
          page << "$('error_message').show()"
        end
      end
    end
  end

  def edit
    @general_availabilities = GeneralAvailability.all(:conditions => "user_id IS NULL OR user_id = '#{current_user.id}'")
    if request.xhr?
      render :update do |page|
        page << "$('add_or_edit_general_availability_ajax_loader').hide()"
        page.replace_html "general_availability_container", :partial => "general_availabilities/edit_general_availability"
      end
    end
  end

  def update
    unless params[:general_availability].blank?
      current_user.user_general_availabilities.destroy_all
      general_availability_values = []
      params[:general_availability].each do |key, val|
        general_availability_values << {:user_id => current_user.id, :general_availability_id => key}
      end
      UserGeneralAvailability.create(general_availability_values)
    end

    current_user.reload
    @my_general_availabilities = current_user.user_general_availabilities
    if request.xhr?
      render :update do |page|
        page.replace_html "general_availability_container", :partial => "general_availabilities/general_availability_list"
      end
    end
  end

  def index
    @my_general_availabilities = current_user.user_general_availabilities
    if request.xhr?
      render :update do |page|
        page << "$('list_index_general_availability_ajax_loader').hide()"
        page.replace_html "general_availability_container", :partial => "general_availabilities/general_availability_list"
      end
    end
  end

  def destroy
    current_user.user_general_availabilities.destroy_all
    current_user.reload
    @my_general_availabilities = current_user.user_general_availabilities
    if request.xhr?
      render :update do |page|
        page << "$('add_or_edit_general_availability_ajax_loader').hide()"
        page.replace_html "general_availability_container", :partial => "general_availabilities/general_availability_list"
      end
    end
  end

  def new_custom_availability
    if request.xhr?
      render :update do |page|
        page << "$('nav_new_custom_availability').hide()"
        page.replace_html "new_custom_availability_form_container", :partial => "new_custom_general_availability"
      end
    end
  end

  def save_new_custom_availability
    @general_availability = GeneralAvailability.new(:name => params[:custom_general_availability], :user_id => params[:user_id])
    if @general_availability.save
      current_user.reload
      my_availabilities_count = current_user.general_availabilities.count
      if request.xhr?
        render :update do |page|
          if (my_availabilities_count % 2).eql?(0)
            page.insert_html :bottom, 'general_availability_form_container', :partial => "checkbox_general_availability", :locals => {:general_availability => @general_availability, :my_availabilities_count => my_availabilities_count}
          else
            page.insert_html :bottom, 'general_availability_form_container', :partial => "checkbox_general_availability", :locals => {:general_availability => @general_availability, :my_availabilities_count => my_availabilities_count}
          end
          page << "$(\"new_custom_availability_form_container\").innerHTML = \"\";$('nav_new_custom_availability').show();"
        end
      end
    else
      if request.xhr?
        render :update do |page|
          page << "$('custom_availability_cant_blank').hide()"
          page << "$('custom_availability_name_has_been_taken').show()"
        end
      end
    end
  end
  
end
