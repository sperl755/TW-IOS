class ApplicationsController < BaseController
  layout :set_layout
  before_filter :check_current_user
  before_filter :check_right, :only => [:new]
  before_filter :check_job_owner_and_status, :only =>[:change_application_status]
  # GET /applications
  # GET /applications.xml
  def index
    @applications = Application.find(:all,:conditions=>['user_id=?',current_user.id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.xml
  def show
    @application = Application.find(params[:id])
    @message = Message.new(:messageable_type=>"application",:messageable_id=>params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @application }
    end
  end

  #TODO This code need to optimize to improve the security.
  def send_application_message
    if params[:message][:messageable_id].to_i > 0 && !params[:message][:messageable_type].blank?
      klass = params[:message][:messageable_type].capitalize.constantize
      @messageable = klass.find(params[:message][:messageable_id])
      @message = @messageable.messages.new(params[:message])
      @application = @messageable
      @message.sender = current_user
      if @message.messageable_type == "Application"
        @message.recipient = Application.get_message_to(@application, current_user.id)
      end
      @message.subject = user_display_name(current_user)+" has sent you a message for "+@application.job.title
      unless @message.valid?
        render :action => :show, :id => @messageable.id and return
      else
        @message.save
        redirect_to :action => :show, :id => @messageable.id
          return
      end
    end
  end
  
  # GET /applications/new
  # GET /applications/new.xml
  def new
    @application = Application.new
    #@application.bids.build
    #@bid = Bid.new
    @job = Job.find_by_id(params[:job_id])

    @application.job_id = @job.id
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @application }
    end
  end

  # GET /applications/1/edit
  def edit
    @application = Application.find(params[:id])
    #@application.bids.build
    #@bid = Bid.new
  end

  # POST /applications
  # POST /applications.xml
  def create
    @application = Application.new(params[:application])
    #@application.bids.build
    # @bid = Bid.new(params[:bid])
    #check_bid = @bid.valid?
    @job = Job.find_by_id(@application.job_id)
    @application.user_id = current_user.id
    respond_to do |format|
      if @application.save
        flash[:notice] = 'Application was successfully created.'
        format.html { redirect_to(applications_url) }
        format.xml  { render :xml => @application, :status => :created, :location => @application }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @application.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /applications/1
  # PUT /applications/1.xml
  def update
    @application = Application.find(params[:id])
                                                  
    respond_to do |format|
      if @application.update_attributes(params[:application])
        flash[:notice] = 'Application was successfully updated.'
        format.html { redirect_to(@application) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @application.errors, :status => :unprocessable_entity }
      end
    end
  end

  def change_application_status
    @application.update_attribute(:status,@new_status_id)
    if @new_status == "hired"
      Contract.create(:user_id=>current_user.id,:job_id=>@application.job_id,:application_id=>@application.id,:status=>false)
    end
    redirect_to contracts_url
  end

  # DELETE /applications/1
  # DELETE /applications/1.xml
  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    respond_to do |format|
      format.html { redirect_to(applications_url) }
      format.xml  { head :ok }
    end
  end

  private
  def check_right
      job_id = params[:job_id].to_i
      if !job_id.blank? && job_id > 0
        object = Job.find_by_id(job_id)
        application = Application.find(:first,:conditions=>['job_id=? and user_id=?',object.id,current_user.id])
        if !application.nil?
          flash[:notice] = "You have already applied on this job."
          redirect_to show_job_url(object.title.parameterize.wrapped_string,object.id)
        elsif object.user_id == current_user.id
          flash[:notice] = "You are not allowed to apply on your created job."
          redirect_to user_jobs_list_by_status_url(current_user.id, "open")
        end
      end
  end

  def check_job_owner_and_status
    pp "nnnnnnnnnnnn"
    @new_status = params[:new_status]
    @new_status_id = APP_CONFIG['job_application_status']["#{@new_status}"]
    @application = Application.find_by_id(params[:id])
    flag = 0
    flag = 1 if @application.status >= @new_status_id
    flag = 1 if @application.job.user_id != current_user.id
    if flag == 1
      redirect_to show_job_url(@application.job.title.parameterize.wrapped_string,@application.job_id)
    end
  end
end
