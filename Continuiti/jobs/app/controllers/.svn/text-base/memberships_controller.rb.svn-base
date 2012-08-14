class MembershipsController < ApplicationController
  # GET /memberships
  # GET /memberships.xml
  before_filter :check_ownership, :only => [:edit, :update, :destroy, :new, :create]
  def index
    @memberships = Membership.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @memberships }
    end
  end

  # GET /memberships/1
  # GET /memberships/1.xml
  def show
    @membership = Membership.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @membership }
    end
  end

  # GET /memberships/new
  # GET /memberships/new.xml
  def new
    if request.xhr?
      render :update do |page|
        page.replace_html "add_membership_form", :partial => "form"
        page << "$('add_new_membership_ajax_loader').hide()"
      end
    end
  end

  # GET /memberships/1/edit
  def edit
    @membership = Membership.find(params[:id])
    @membership.from_year = @membership.from_date.strftime("%Y")
    @membership.until_year = @membership.until_date.strftime("%Y")
    if request.xhr?
      render :update do |page|
        page.replace_html "add_membership_form", :partial => "edit"
        page << "$('add_new_membership_ajax_loader').hide()"
      end
    end
  end

  # POST /memberships
  # POST /memberships.xml
  def create
    valid = true
    render :update do |page|
      if request.xhr?
        currently_membership_name = []
        params[:membership].each do |key, value|
          if params[:membership][key.to_s][:to_present].eql?("1")
            current_date = Time.now
            params[:membership][key.to_s]["until_date(1i)"] = params[:membership][key.to_s][:until_year] = current_date.strftime("%Y")
            params[:membership][key.to_s]["until_date(2i)"] = current_date.strftime("%m")
          else
            params[:membership][key.to_s]["until_date(1i)"] = params[:membership][key.to_s][:until_year]
          end
          params[:membership][key.to_s]["from_date(1i)"] = params[:membership][key.to_s][:from_year]
          params[:membership][key.to_s]["from_date(3i)"] = "1"
          params[:membership][key.to_s]["until_date(3i)"] = "1"
          @membership = Membership.new(params[:membership][key.to_s])
          @membership.user_id = current_user.id
          unless @membership.valid?
            valid = false
            if @membership.errors.to_a.map{|err| err[0]}.include?("name")
              page << "$('membership_name_must_unique_#{key}').show()"
              page << "$('membership_name_cant_be_blank_#{key}').hide()"
            elsif @membership.errors.to_a.map{|err| err[0]}.include?("until_date")
              page << "$('membership_end_year_must_greater_than_start_year_#{key}').show()"
            end
          else
            if currently_membership_name.include?(params[:membership][key.to_s][:name])
              valid = false
              page << "$('membership_name_must_unique_#{key}').show()"
              page << "$('membership_name_cant_be_blank_#{key}').hide()"
            else
              page << "$('membership_name_must_unique_#{key}').hide()"
              page << "$('membership_name_cant_be_blank_#{key}').hide()"
            end
            currently_membership_name << params[:membership][key.to_s][:name]
          end
        end
      end

      if valid
        params[:membership].each do |key, value|
          @memberships = []
          if params[:membership][key.to_s][:to_present].eql?("1")
            current_date = Time.now
            params[:membership][key.to_s]["until_date(1i)"] = params[:membership][key.to_s][:until_year] = current_date.strftime("%Y")
            params[:membership][key.to_s]["until_date(2i)"] = current_date.strftime("%m")
          else
            params[:membership][key.to_s]["until_date(1i)"] = params[:membership][key.to_s][:until_year]
          end
          params[:membership][key.to_s]["from_date(1i)"] = params[:membership][key.to_s][:from_year]
          params[:membership][key.to_s]["from_date(3i)"] = "1"
          params[:membership][key.to_s]["until_date(3i)"] = "1"
          @membership = Membership.new(params[:membership][key.to_s])
          @membership.user_id = current_user.id

          @membership.save
          if request.xhr?
            @memberships << @membership
            page.insert_html :top, "membership_index_container", :partial => "index"
            page << "$(\"add_membership_form\").innerHTML = \"\""
          end
        end
      end
    end
  end

  # PUT /memberships/1
  # PUT /memberships/1.xml
  def update
    if params[:membership][:to_present].eql?("1")
      current_date = Time.now
      params[:membership]["until_date(1i)"] = params[:membership][:until_year] = current_date.strftime("%Y")
      params[:membership]["until_date(2i)"] = current_date.strftime("%m")
    else
      params[:membership]["until_date(1i)"] = params[:membership][:until_year]
    end
    params[:membership]["from_date(1i)"] = params[:membership][:from_year]
    params[:membership]["from_date(3i)"] = "1"
    params[:membership]["until_date(3i)"] = "1"
    
    @membership = Membership.find(params[:id])

    if @membership.update_attributes(params[:membership])
      if request.xhr?
        @memberships = Membership.all(:conditions => "user_id = '#{current_user.id}'", :order => "created_at DESC")
        render :update do |page|
          page.replace_html "membership_index_container", :partial => "index", :locals => {:memberships => @memberships}
          page << "$(\"add_membership_form\").innerHTML = \"\""
        end
      end
    else
      if request.xhr?
        render :update do |page|
          if @membership.errors.to_a.map{|err| err[0]}.include?("name")
            page << "$('membership_name_must_unique_0').show()"
            page << "$('membership_name_cant_be_blank_0').hide()"
          elsif @membership.errors.to_a.map{|err| err[0]}.include?("until_date")
            page << "$('membership_end_year_must_greater_than_start_year_0').show()"
          end
        end
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.xml
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy

    if request.xhr?
      @memberships = Membership.all(:conditions => "user_id = '#{current_user.id}'", :order => "created_at DESC")
      render :update do |page|
        page.replace_html "membership_index_container", :partial => "index", :locals => {:memberships => @memberships}
      end
    end
  end

  private

  def check_ownership
    if check_current_user && !admin?
      id = params[:id].to_i
      if !id.blank? && id > 0
        object = Membership.find_by_id(params[:id])
        if object.user_id != current_user.id
          flash[:notice] = "You are not allowed for the requested page."
          redirect_to home_url
        end
      end
    end
  end
end
