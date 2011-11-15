class ExperiencesController < BaseController
  # GET /experiences
  # GET /experiences.xml
  layout 'application'
  before_filter :check_ownership, :only => [:edit, :update, :destroy, :new, :create]
  
  def index
    @experiences = Experience.find(:all, :conditions => ["user_id = ?", current_user.id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @experiences }
    end
  end
  
  def _index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @experiences }
    end
  end
  
  # GET /experiences/1
  # GET /experiences/1.xml
  def show
    @experience = Experience.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @experience }
    end
  end
  
  # GET /experiences/new
  # GET /experiences/new.xml
  def new
    if request.xhr?
      render :update do |page|
        page.replace_html "add_experience_form", :partial => "form"
        page << "$('add_new_experience_ajax_loader').hide()"
      end
    end
  end
  
  # GET /experiences/1/edit
  def edit
    @experience = Experience.find(params[:id])
    if request.xhr?
      render :update do |page|
        page.replace_html "add_experience_form", :partial => "edit"
        page << "$('add_new_experience_ajax_loader').hide()"
      end
    end
  end
  
  # POST /experiences
  # POST /experiences.xml
  def create
    valid = true
    render :update do |page|
      if request.xhr?
        params[:experience].each do |key, value|
          @experience = Experience.new(params[:experience][key.to_s])
          @experience.user_id = current_user.id
          unless @experience.valid?
            valid = false
            if @experience.errors.to_a.map{|err| err[0]}.include?("base")
              page << "$('experience_end_year_must_greater_than_start_year_#{key}').show()"
              page << "$('experience_year_must_enter_after_1900_#{key}').hide()"
            else
              page << "$('experience_end_year_must_greater_than_start_year_#{key}').hide()"
              page << "$('experience_year_must_enter_after_1900_#{key}').hide()"
            end
            if @experience.errors.to_a.map{|err| err[0]}.include?("company_url")
              page << "$('experience_company_url_not_valid_#{key}').show()"
            else
              page << "$('experience_company_url_not_valid_#{key}').hide()"
            end
          end
        end
      end

      if valid
        params[:experience].each do |key, value|
          @experiences = []
          @experience = Experience.new(params[:experience][key.to_s])
          @experience.user_id = current_user.id

          @experience.save
          if request.xhr?
            @experiences << @experience
            page.insert_html :top, "experience_index_container", :partial => "index"
            page << "$(\"add_experience_form\").innerHTML = \"\""
          end
        end
      end
    end
  end
  
  # PUT /experiences/1
  # PUT /experiences/1.xml
  def update
    @experience = Experience.find(params[:id])

    if @experience.update_attributes(params[:experience])
      if request.xhr?
        @experiences = Experience.find(:all, :conditions => ["user_id = ?", current_user.id], :order => "created_at DESC")
        render :update do |page|
          page.replace_html "experience_index_container", :partial => "index", :locals => {:experiences => @experiences}
          page << "$(\"add_experience_form\").innerHTML = \"\""
        end
      end
    else
      if request.xhr?
        render :update do |page|
          if @experience.errors.to_a.map{|err| err[0]}.include?("base")
            page << "$('experience_end_year_must_greater_than_start_year_0').show()"
            page << "$('experience_year_must_enter_after_1900_0').hide()"
          else
            page << "$('experience_end_year_must_greater_than_start_year_0').hide()"
            page << "$('experience_year_must_enter_after_1900_0').hide()"
          end
          if @experience.errors.to_a.map{|err| err[0]}.include?("company_url")
            page << "$('experience_company_url_not_valid_0').show()"
          else
            page << "$('experience_company_url_not_valid_0').hide()"
          end
        end
      end
    end
  end
  
  # DELETE /experiences/1
  # DELETE /experiences/1.xml
  def destroy
    @experience = Experience.find(params[:id])
    @experience.destroy

    if request.xhr?
      @experiences = Experience.find(:all, :conditions => ["user_id = ?", current_user.id], :order => "created_at DESC")
      render :update do |page|
        page.replace_html "experience_index_container", :partial => "index", :locals => {:experiences => @experiences}
      end
    end
  end
  
  private
  def check_ownership
    if check_current_user && !admin?
      id = params[:id].to_i
      if !id.blank? && id > 0
        object = Experience.find_by_id(params[:id])
        if object.user_id != current_user.id
          flash[:notice] = "You are not allowed for the requested page."
          redirect_to home_url
        end
      end
    end
  end
  
end
