class CertificationsController < ApplicationController
  # GET /certifications
  # GET /certifications.xml
  before_filter :check_ownership, :only => [:edit, :update, :destroy, :new, :create]
  def index
    @certifications = Certification.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @certifications }
    end
  end

  # GET /certifications/1
  # GET /certifications/1.xml
  def show
    @certification = Certification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @certification }
    end
  end

  # GET /certifications/new
  # GET /certifications/new.xml
  def new
    if request.xhr?
      render :update do |page|
        page.replace_html "add_certification_form", :partial => "form"
        page << "$('add_new_certification_ajax_loader').hide()"
      end
    end
  end

  # GET /certifications/1/edit
  def edit
    @certification = Certification.find(params[:id])
    @certification.award_year = @certification.award_date.strftime("%Y")
    if request.xhr?
      render :update do |page|
        page.replace_html "add_certification_form", :partial => "edit"
        page << "$('add_new_certification_ajax_loader').hide()"
      end
    end
  end

  # POST /certifications
  # POST /certifications.xml
  def create
    valid = true
    render :update do |page|
      if request.xhr?
        currently_title_certification = []
        params[:certification].each do |key, value|
          params[:certification][key.to_s]["award_date(1i)"] = params[:certification][key.to_s][:award_year]
          params[:certification][key.to_s]["award_date(3i)"] = "1"
          @certification = Certification.new(params[:certification][key.to_s])
          @certification.user_id = current_user.id
          unless @certification.valid?
            valid = false
            if @certification.errors.to_a.map{|err| err[0]}.include?("title")
              page << "$('certification_title_must_unique_#{key}').show()"
              page << "$('certification_title_cant_be_blank_#{key}').hide()"
            end
          else
            if currently_title_certification.include?(params[:certification][key.to_s][:title])
              valid = false
              page << "$('certification_title_must_unique_#{key}').show()"
              page << "$('certification_title_cant_be_blank_#{key}').hide()"
            else
              page << "$('certification_title_must_unique_#{key}').hide()"
              page << "$('certification_title_cant_be_blank_#{key}').hide()"
            end
            currently_title_certification << params[:certification][key.to_s][:title]
          end
        end
      end

      if valid
        params[:certification].each do |key, value|
          @certifications = []
          params[:certification][key.to_s]["award_date(1i)"] = params[:certification][key.to_s][:award_year]
          params[:certification][key.to_s]["award_date(3i)"] = "1"
          @certification = Certification.new(params[:certification][key.to_s])
          @certification.user_id = current_user.id

          @certification.save
          if request.xhr?
            @certifications << @certification
            page.insert_html :top, "certification_index_container", :partial => "index"
            page << "$(\"add_certification_form\").innerHTML = \"\""
          end
        end
      end
    end
  end

  # PUT /certifications/1
  # PUT /certifications/1.xml
  def update
    params[:certification]["award_date(1i)"] = params[:certification][:award_year]
    params[:certification]["award_date(3i)"] = "1"
    
    @certification = Certification.find(params[:id])

    if @certification.update_attributes(params[:certification])
      if request.xhr?
        @certifications = Certification.all(:conditions => "user_id = '#{current_user.id}'", :order => "created_at DESC")
        render :update do |page|
          page.replace_html "certification_index_container", :partial => "index", :locals => {:certifications => @certifications}
          page << "$(\"add_certification_form\").innerHTML = \"\""
        end
      end
    else
      if request.xhr?
        render :update do |page|
          if @certification.errors.to_a.map{|err| err[0]}.include?("title")
            page << "$('certification_title_must_unique_0').show()"
            page << "$('certification_title_cant_be_blank_0').hide()"
          end
        end
      end
    end
  end

  # DELETE /certifications/1
  # DELETE /certifications/1.xml
  def destroy
    @certification = Certification.find(params[:id])
    @certification.destroy
    if request.xhr?
      @certifications = Certification.all(:conditions => "user_id = '#{current_user.id}'", :order => "created_at DESC")
      render :update do |page|
        page.replace_html "certification_index_container", :partial => "index", :locals => {:certifications => @certifications}
      end
    end
  end

  private

  def check_ownership
    if check_current_user && !admin?
      id = params[:id].to_i
      if !id.blank? && id > 0
        object = Certification.find_by_id(params[:id])
        if object.user_id != current_user.id
          flash[:notice] = "You are not allowed for the requested page."
          redirect_to home_url
        end
      end
    end
  end
end
