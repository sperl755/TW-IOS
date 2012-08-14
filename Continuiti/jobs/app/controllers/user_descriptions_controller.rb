class UserDescriptionsController < ApplicationController
  def new
    @user_description = UserDescription.new
    @user_description.user_id = current_user.id

    if request.xhr?
      render :update do |page|
        page << "$('user_description_index_container').hide()"
        page.replace_html "add_user_description_form", :partial => "form"
        page << "$('add_new_user_description_ajax_loader').hide()"
      end
    end
  end

  def create
    @user_description = UserDescription.new(params[:user_description])

    if @user_description.save
      current_user.reload
      if request.xhr?
        render :update do |page|
          page << "$('add_new_user_description_navigation').hide()"
          page << "$('user_description_index_container').show()"
          page.replace_html "user_description_index_container", :partial => "show"
          page << "$(\"add_user_description_form\").innerHTML = \"\""
        end
      end
    else
      if request.xhr?
        render :update do |page|
          page << "$('error_message').innerHTML='Please fill all fields!!!'"
        end
      end
    end
  end

  def edit
    @user_description = UserDescription.find(current_user.user_description.id)
    if request.xhr?
      render :update do |page|
        page << "$('user_description_index_container').hide()"
        page.replace_html "add_user_description_form", :partial => "edit"
      end
    end
  end

  def update
    @user_description = UserDescription.find(current_user.user_description.id)

    if @user_description.update_attributes(params[:user_description])
      current_user.reload
      if request.xhr?
        render :update do |page|
          page << "$('user_description_index_container').show()"
          page.replace_html "user_description_index_container", :partial => "show"
          page << "$(\"add_user_description_form\").innerHTML = \"\""
        end
      end
    else
      if request.xhr?
        render :update do |page|
          page << "$('error_message').innerHTML='Please fill all fields!!!'"
        end
      end
    end
  end

  def destroy
    @user_description = UserDescription.find(current_user.user_description.id)
    @user_description.destroy
    if request.xhr?
      current_user.reload
      render :update do |page|
        page << "$('add_new_user_description_navigation').show()"
        page << "$('user_description_index_container').show()"
        page.replace_html "user_description_index_container", :partial => "show"
      end
    end
  end
end
