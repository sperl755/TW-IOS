class ContractsController < BaseController
  # GET /contracts
  # GET /contracts.xml
  before_filter :check_ownership
  def index
    @contracts = Contract.find(:all, :conditions => ['user_id=? or contractor_id=?',current_user.id, current_user.id])
    #@contracts = Contract.find(:all, :conditions => ['user_id=?',current_user.id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contracts }
    end
  end

  # GET /contracts/1
  # GET /contracts/1.xml
  def show
    
    @contract = Contract.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contract }
    end
  end

#  # GET /contracts/new
#  # GET /contracts/new.xml
#  def new
#    @contract = Contract.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @contract }
#    end
#  end
#
#  # GET /contracts/1/edit
#  def edit
#    @contract = Contract.find(params[:id])
#  end
#
#  # POST /contracts
#  # POST /contracts.xml
#  def create
#    @contract = Contract.new(params[:contract])
#
#    respond_to do |format|
#      if @contract.save
#        flash[:notice] = 'Contract was successfully created.'
#        format.html { redirect_to(@contract) }
#        format.xml  { render :xml => @contract, :status => :created, :location => @contract }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @contract.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
  # PUT /contracts/1
  # PUT /contracts/1.xml
  def update
    @contract = Contract.find(params[:id])
    @contract.application.status = APP_CONFIG['job_application_status']['closed']
    @contract.application.save
    @contract.feedback_type = params[:contract][:feedback_type]
    @contract.end_datetime = Time.now if @contract.end_datetime.nil?
    @contract.status = APP_CONFIG['contract_status']['end']
    @contract.ended_by = current_user.id if @contract.ended_by.nil? || @contract.ended_by == 0

    if @contract.user_id == current_user.id
      @contract.end_employer_comment = params[:contract][:end_employer_comment]
      @contract.work_again_with_contractor = params[:contract][:work_again_with_contractor]
    elsif @contract.contractor_id == current_user.id
      @contract.end_contractor_comment = params[:contract][:end_contractor_comment]
      @contract.work_again_with_employer = params[:contract][:work_again_with_employer]
    end
    unless @contract.valid?
      if @contract.user_id == current_user.id
        render :action=>"employer_end"
      elsif @contract.contractor_id == current_user.id
        render :action=>"contractor_end"
      end
    end
      if @contract.save
        Rate.update_all("active=1","rater_id="+current_user.id.to_s+" and rateable_id="+@contract.id.to_s+" and rateable_type='Contract'")
        flash[:notice] = 'Contract has successfully ended.'
        redirect_to(@contract) 
      end
  end
#
#  # DELETE /contracts/1
#  # DELETE /contracts/1.xml
#  def destroy
#    @contract = Contract.find(params[:id])
#    @contract.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(contracts_url) }
#      format.xml  { head :ok }
#    end
#  end

  def activate
    contract = Contract.find_by_id(params[:id])
    if !contract.nil? && contract.status==0 && contract.application.user_id == current_user.id
      contract.update_attributes(:status=>1,:start_date=>Date.today)
    end
    redirect_to contracts_url 
  end

  def employer_end
    @contract = Contract.find_by_id(params[:id])
  end

  def contractor_end
    @contract = Contract.find_by_id(params[:id])
  end

  def rate
    @contract = Contract.find_by_id(params[:id])
    @contract.rate(params[:stars], current_user, params[:dimension])
    @user = current_user
    render :update do |page|
      page.replace_html @contract.wrapper_dom_id(params), ratings_for(@contract, params.merge(:wrap => false))
      page.visual_effect :highlight, @contract.wrapper_dom_id(params)
    end
  end

  private
  def check_ownership
    redirect_to :controller => 'sessions', :action => 'new' and return false unless current_user
    unless admin?
      id = params[:id].to_i
      if !id.blank? && id > 0
        object = Contract.find_by_id(params[:id])
        if object.user_id != current_user.id && object.contractor_id != current_user.id
          flash[:notice] = "You are not allowed for the requested page."
          redirect_to home_url
        end
      end
    end
  end
end
