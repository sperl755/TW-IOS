class EducationsController < BaseController
  # GET /educations
  # GET /educations.xml
  #layout 'application'
  before_filter :check_ownership, :only => [:edit, :update, :destroy, :new, :create]
  def index
    @educations = Education.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @educations }
    end
  end

  # GET /educations/1
  # GET /educations/1.xml
  def show
    @education = Education.find(params[:id])
	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @education }
    end
  end

  # GET /educations/new
  # GET /educations/new.xml
  def new
    if request.xhr?
      render :update do |page|
        page.replace_html "add_education_form", :partial => "form"
        page << "$('add_new_education_ajax_loader').hide()"
      end
    end
  end

  # GET /educations/1/edit
  def edit
    @education = Education.find(params[:id])
    if request.xhr?
      render :update do |page|
        page.replace_html "add_education_form", :partial => "edit"
        page << "$('add_new_education_ajax_loader').hide()"
      end
    end
  end

  # POST /educations
  # POST /educations.xml
  def create
    valid = true
    render :update do |page|
      if request.xhr?
        params[:education].each do |key, value|
          @education = Education.new(params[:education][key.to_s])
          @education.user_id = current_user.id
          unless @education.valid?
            valid = false
            if @education.errors.to_a.map{|err| err[0]}.include?("url")
              page << "$('education_university_url_not_valid_#{key}').show()"
            end
          else
            page << "$('education_university_url_not_valid_#{key}').hide()"
          end
        end
      end

      if valid
        params[:education].each do |key, value|
          @educations = []
          @education = Education.new(params[:education][key.to_s])
          @education.user_id = current_user.id

          @education.save
          if request.xhr?
            @educations << @education
            page.insert_html :top, "education_index_container", :partial => "index"
            page << "$(\"add_education_form\").innerHTML = \"\""
          end
        end
      end
    end
  end

  # PUT /educations/1
  # PUT /educations/1.xml
  def update
    @education = Education.find(params[:id])

    render :update do |page|
      if @education.update_attributes(params[:education])
        if request.xhr?
          @educations = Education.find(:all, :conditions => ["user_id = ?", current_user.id], :order => "created_at DESC")
          page.replace_html "education_index_container", :partial => "index", :locals => {:educations => @educations}
          page << "$(\"add_education_form\").innerHTML = \"\""
        end
      else
        if request.xhr?
          if @education.errors.to_a.map{|err| err[0]}.include?("url")
            page << "$('education_university_url_not_valid_0').show()"
          end
        end
      end
    end
  end

  # DELETE /educations/1
  # DELETE /educations/1.xml
  def destroy
    @education = Education.find(params[:id])
    @education.destroy

    if request.xhr?
      @educations = Education.find(:all, :conditions => ["user_id = ?", current_user.id], :order => "created_at DESC")
      render :update do |page|
        page.replace_html "education_index_container", :partial => "index", :locals => {:educations => @educations}
      end
    end
  end
  
  private
  def check_ownership
    pp check_current_user
    if check_current_user && !admin?
      id = params[:id].to_i
      pp id
      if !id.blank? && id > 0
        object = Education.find_by_id(params[:id])
        pp object
        pp current_user
        if object.user_id != current_user.id
          flash[:notice] = "You are not allowed for the requested page."
          redirect_to home_url
        end
      end
    end
  end
  
end
