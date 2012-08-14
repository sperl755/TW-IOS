class CompaniesController < BaseController
  before_filter :login_required
  before_filter :load_user
  uses_tiny_mce(:only => [:new, :create, :update, :edit]) do
    AppConfig.default_mce_options.merge({:editor_selector => "rich_text_editor"})
  end
  uses_tiny_mce(:only => [:show]) do
    AppConfig.simple_mce_options
  end
  # GET /companies
  # GET /companies.xml
  def index
    @companies = @user.companies

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    @company = Company.find(params[:id])
    init_gmap
    @company_followers = @company.followers
    @following_company = @user.following_company
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new
    @company.build_company_photo
    @company.offices.build
    #    @company.company_photo = CompanyPhoto.new(:company_id => @company.id)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
    @company.build_company_photo if @company.company_photo.blank?
    @company.offices.build if @company.offices.blank?
    @company.offices.length
  end

  # POST /companies
  # POST /companies.xml
  def create
    @company = Company.new(params[:company].merge(:user_id=>current_user.id))

    respond_to do |format|
      if @company.save
        #         CompanyPhoto.create!(params[:company][:company_photo_attributes].merge(:company_id=>@company.id))
        flash[:notice] = 'Company was successfully created.'
        format.html {redirect_to user_company_path(@user, @company) }
        #        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { 
          @company.build_company_photo
          @company.offices.build
          render :action => "new"

        }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes!(params[:company])
        flash[:notice] = 'Company was successfully updated.'
        format.html { redirect_to user_company_path(@user, @company) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
    end
  end
  

  def follow
    @company = Company.find(params[:id])
    if CompanyFollower.create(:company_id => params[:id], :follower_id => current_user.id)
      flash[:notice] = 'You are now following this company.' #unless request.xhr?
    else
      flash[:notice] = 'Sorry, something went wrong. Please try again later.' 
    end
    respond_to do |format|
      format.html{redirect_to :back}
      format.js
    end
  end

  def unfollow
    @company = Company.find(params[:id])
    company_follower = CompanyFollower.find_by_company_id_and_follower_id(params[:id], current_user.id)
    if company_follower.destroy
      flash[:notice] = 'You are not following this company now.' 
    else
      flash[:notice] = 'Sorry, something went wrong. Please try again later.' 
    end
    respond_to do |format|
      format.html{redirect_to :back}
      format.js{render :template => "/companies/follow.js.rjs"}
    end
  end

  def search
    @search = Sunspot.search(Company) do
      keywords(params[:searchterm])
    end
    render :action=>:index
  end
  
  private
  def load_user
    @user = User.find(params[:user_id])
  end

  def init_gmap
    #    offices =
    @map = {}
    @company.offices.each do |office|
      #      coordinates = [41.8921254,-87.6096669]      
      coordinates = [office.latitude, office.longitude]
      @map[:office => office.office_name] = GMap.new("map_#{office.office_name}")
      @map[:office => office.office_name].control_init(:large_map => true, :map_type => true)
      @map[:office => office.office_name].center_zoom_init(coordinates,15)
      @map[:office => office.office_name].overlay_init(GMarker.new(coordinates,:title => "Company Office"))
    end
    

  end
end
