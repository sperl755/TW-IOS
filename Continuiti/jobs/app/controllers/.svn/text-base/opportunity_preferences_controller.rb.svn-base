class OpportunityPreferencesController < ApplicationController
  def new
    @opportunity_preferences = OpportunityPreference.all
    if request.xhr?
      render :update do |page|
        page.replace_html "opportunity_preference_container", :partial => "users/new_opportunity_preference"
      end
    end
  end

  def create
    unless params[:opportunity_preference].blank?
      opportunity_preference_values = []
      params[:opportunity_preference].each do |key, val|
        opportunity_preference_values << {:user_id => current_user.id, :opportunity_preference_id => key}
      end
      UserOpportunityPreference.create(opportunity_preference_values)

      current_user.reload
      @my_opportunity_preferences = UserOpportunityPreference.find_all_by_user_id(current_user.id)
      if request.xhr?
        render :update do |page|
          page.replace_html "opportunity_preference_container", :partial => "users/opportunity_preferences_list"
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
    @opportunity_preferences = OpportunityPreference.all
    if request.xhr?
      render :update do |page|
        page << "$('add_or_edit_opportunity_preferences_ajax_loader').hide()"
        page.replace_html "opportunity_preference_container", :partial => "users/edit_opportunity_preference"
      end
    end
  end

  def update
    unless params[:opportunity_preference].blank?
      current_user.user_opportunity_preferences.destroy_all
      opportunity_preference_values = []
      params[:opportunity_preference].each do |key, val|
        opportunity_preference_values << {:user_id => current_user.id, :opportunity_preference_id => key}
      end
      UserOpportunityPreference.create(opportunity_preference_values)
    end

    current_user.reload
    @my_opportunity_preferences = UserOpportunityPreference.find_all_by_user_id(current_user.id)
    if request.xhr?
      render :update do |page|
        page.replace_html "opportunity_preference_container", :partial => "users/opportunity_preferences_list"
      end
    end
  end

  def index
    @my_opportunity_preferences = UserOpportunityPreference.find_all_by_user_id(current_user.id)
    if request.xhr?
      render :update do |page|
        page << "$('list_index_opportunity_preferences_ajax_loader').hide()"
        page.replace_html "opportunity_preference_container", :partial => "users/opportunity_preferences_list"
      end
    end
  end

  def destroy
    current_user.user_opportunity_preferences.destroy_all
    current_user.reload
    @my_opportunity_preferences = UserOpportunityPreference.find_all_by_user_id(current_user.id)
    if request.xhr?
      render :update do |page|
        page << "$('add_or_edit_opportunity_preferences_ajax_loader').hide()"
        page.replace_html "opportunity_preference_container", :partial => "users/opportunity_preferences_list"
      end
    end
  end

end
