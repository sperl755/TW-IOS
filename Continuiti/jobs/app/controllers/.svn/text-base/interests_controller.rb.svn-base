class InterestsController < ApplicationController
  # GET /interests
  # GET /interests.xml
  before_filter :check_ownership, :only => [:edit, :update, :destroy, :new, :create]
  def index
    @interests = Interest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @interests }
    end
  end

  # GET /interests/1
  # GET /interests/1.xml
  def show
    @interest = Interest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @interest }
    end
  end

  # GET /interests/new
  # GET /interests/new.xml
  def new
    if request.xhr?
      render :update do |page|
        page.replace_html "add_interest_form", :partial => "form"
        page << "$('add_new_interest_ajax_loader').hide()"
      end
    end
  end

  # GET /interests/1/edit
  def edit
    @interest = Interest.find(params[:id])
    if request.xhr?
      render :update do |page|
        page.replace_html "add_interest_form", :partial => "edit"
        page << "$('add_new_interest_ajax_loader').hide()"
      end
    end
  end

  # POST /interests
  # POST /interests.xml
  def create
    valid = true
    render :update do |page|
      if request.xhr?
        currently_name_interest = []
        params[:interest].each do |key, value|
          @interest = Interest.new(params[:interest][key.to_s])
          @interest.user_id = current_user.id
          unless @interest.valid?
            valid = false
            if @interest.errors.to_a.map{|err| err[0]}.include?("name")
              page << "$('interest_name_must_unique_#{key}').show()"
              page << "$('interest_name_cant_be_blank_#{key}').hide()"
            end
          else
            if currently_name_interest.include?(params[:interest][key.to_s][:name])
              valid = false
              page << "$('interest_name_must_unique_#{key}').show()"
              page << "$('interest_name_cant_be_blank_#{key}').hide()"
            else
              page << "$('interest_name_must_unique_#{key}').hide()"
              page << "$('interest_name_cant_be_blank_#{key}').hide()"
            end
            currently_name_interest << params[:interest][key.to_s][:name]
          end
        end
      end

      if valid
        params[:interest].each do |key, value|
          @interests = []
          @interest = Interest.new(params[:interest][key.to_s])
          @interest.user_id = current_user.id

          @interest.save
          if request.xhr?
            @interests << @interest
            page.insert_html :top, "interest_index_container", :partial => "index"
            page << "$(\"add_interest_form\").innerHTML = \"\""
          end
        end
      end
    end
  end

  # PUT /interests/1
  # PUT /interests/1.xml
  def update
    @interest = Interest.find(params[:id])

    if @interest.update_attributes(params[:interest])
      if request.xhr?
        @interests = Interest.all(:conditions => "user_id = '#{current_user.id}'", :order => "created_at DESC")
        render :update do |page|
          page.replace_html "interest_index_container", :partial => "index", :locals => {:interests => @interests}
          page << "$(\"add_interest_form\").innerHTML = \"\""
        end
      end
    else
      if request.xhr?
        render :update do |page|
          if @interest.errors.to_a.map{|err| err[0]}.include?("name")
            page << "$('interest_name_must_unique_0').show()"
            page << "$('interest_name_cant_be_blank_0').hide()"
          end
        end
      end
    end
  end

  # DELETE /interests/1
  # DELETE /interests/1.xml
  def destroy
    @interest = Interest.find(params[:id])
    @interest.destroy

    if request.xhr?
      @interests = Interest.all(:conditions => "user_id = '#{current_user.id}'", :order => "created_at DESC")
      render :update do |page|
        page.replace_html "interest_index_container", :partial => "index", :locals => {:interests => @interests}
      end
    end
  end

  private

  def check_ownership
    if check_current_user && !admin?
      id = params[:id].to_i
      if !id.blank? && id > 0
        object = Interest.find_by_id(params[:id])
        if object.user_id != current_user.id
          flash[:notice] = "You are not allowed for the requested page."
          redirect_to home_url
        end
      end
    end
  end
end
