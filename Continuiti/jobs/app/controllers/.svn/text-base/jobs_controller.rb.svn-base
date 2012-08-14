class JobsController < BaseController
  # GET /jobs
  # GET /jobs.xml
  
  #before_filter :check_current_user
  layout :set_layout
  before_filter :check_current_user, :only => [:show]
  before_filter :check_ownership, :only => [:index, :edit, :update, :destroy, :create, :new, :job_applications]

  def index
    if current_user.admin?
      @jobs = Job.paginate(:per_page => 10, :page => params[:page],:order=>"created_at desc")
    else
      @jobs = Job.paginate( :conditions=>['user_id=?',current_user.id],:per_page => 10, :page => params[:page],:order=>"created_at desc")  
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.xml
  def show
    
    @job = Job.find(params[:id])
    @application = Application.find(:first,:conditions=>['job_id=? and user_id=?',@job.id,current_user.id]) 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    @job = Job.new
    @locations = Location.find(:all, :conditions=>['user_id=?',current_user.id])
    @job.locations.build   # Creating task_location in Memory so that our Form has something to work with when dealing with Task Locations.
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    pp "JJJJJJJJJJJJJJJJJJJJJJJJJJJJ"
    pp current_user
    pp @locations = Location.find(:all, :conditions=>['user_id=?',current_user.id])
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.xml
  def create
    @job = Job.new(params[:job])
    @locations = Location.find(:all, :conditions=>['user_id=?',current_user.id])

    @job.user_id = current_user.id
    @job.status = 0 #job is initially inactive untill payment is processed
    respond_to do |format|
      if @job.save
        flash[:notice] = 'Job was successfully created.'
                #format.html { redirect_to(user_jobs_list_by_status_url(current_user.id,"open")) }
        format.html {redirect_to invest_funds_job_path(@job)}
        format.xml  { render :xml => @job, :status => :created, :location => @job }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.xml
  def update
    @locations = Location.find(:all, :conditions=>['user_id=?',current_user.id])
    params[:job][:existing_location_attributes] ||= {}

    @job = Job.find(params[:id])
    process_file_uploads(@job)
    respond_to do |format|
      if @job.update_attributes(params[:job])
        flash[:notice] = 'Job was successfully updated.'
        # format.html { redirect_to(show_job_path(@job.title.parameterize.downcase.wrapped_string,@job.id)) }
        format.html {redirect_to invest_funds_job_path(@job)}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.xml
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
  end

  def list
    @user_id = params[:user_id]
    @status = params[:status]
    @status_id = APP_CONFIG['job_status'][@status]
    @jobs = Job.find(:all,:conditions=>['user_id=? and status=?',@user_id,@status_id])
  end

  #XXX example implementation of solr search.
  #see:
  # https://github.com/outoftime/sunspot/wiki/Adding-Sunspot-search-to-Rails-in-5-minutes-or-less
  # We use Sunspot.search(model) rather than model.search to avoid conflicts with searchlogic
  def search
    @search = Sunspot.search(Job) do
      keywords(params[:searchterm])
    end
  end 

  def update_visibility
    @id = params[:id].to_i
    if @id>0
      job = Job.find_by_id(@id)
      @new_visible_status = job.visible_status == 0 ? APP_CONFIG['job_visible_status'][0] : APP_CONFIG['job_visible_status'][1]
      visible_status = job.visible_status == 0 ? 1 : 0
      job.visible_status = visible_status
      job.save
      render :partial => 'update_visibility'
    end
  end

  def share_job
    
  end

  def update_form
    cost_method = params[:cost_method]
    if cost_method.to_i>0
      @cost_method = CostMethod.find_by_id(cost_method).title
      render :partial => "update_form"
    else
      render :text=>''
    end
  end
  
  #TODO(Asif) remove tempory_jobs when full functional jobs activities will be ready in my locals
  def temporary_jobs
    @jobs = Job.all
    @cart = current_cart unless session[:cart_id].blank?
  end

  def invest_funds
    @job = Job.find(params[:id])
    @cart = current_cart
    @cart_item = set_cart_item(@cart, @job)
    if @cart_item.unit_price < 1
      redirect_to show_job_path(@job.title.parameterize.downcase.wrapped_string,@job.id)
      return
    end
  end

  def pay_to_users
    @job = Job.find(params[:id])
    @users = User.all #TODO Job.hired_users
  end

  def send_payments_to_users
    @job = Job.find(params[:id])
    render :action=> :pay_to_user
    params[:user][:ids].each do |id|
      user = User.find id
      STANDARD_GATEWAY.transfer 100, user.email
    end

  end
  
  def job_applications
    job_id = params[:id]
    application_status = params[:application_status]
    application_status_id = APP_CONFIG['job_application_status']["#{application_status}"]
    @job = Job.find_by_id(job_id)
    if application_status == "applied"
      @applications = @job.applications
    else
    @applications = Application.find(:all,:conditions=>['job_id=? and status=?',job_id,application_status_id ])
  end
  
  end

  private
  def check_ownership
    redirect_to :controller => 'sessions', :action => 'new' and return false unless current_user
    unless admin?
      id = params[:id].to_i
      if !id.blank? && id > 0
        object = Job.find_by_id(params[:id])
        if object.user_id != current_user.id
          flash[:notice] = "You are not allowed for the requested page."
          redirect_to home_url
        end
      end
    end
  end

  protected
  def process_file_uploads(job)
      i = 0
      while !params[:attachment].nil? && params[:attachment]['file_'+i.to_s] != "" && !params[:attachment]['file_'+i.to_s].nil?
          job.user_files.build(:data => params[:attachment]['file_'+i.to_s])
          i += 1
      end
  end
end
