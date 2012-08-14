class EndorsementsController < ApplicationController
  # GET /endorsements
  # GET /endorsements.xml
  before_filter :save_user_request_endorse_id, :only => :new
  before_filter :check_current_user, :only => :new
  
  def index
    @endorsements = Endorsement.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @endorsements }
    end
  end

  # GET /endorsements/1
  # GET /endorsements/1.xml
  def show
    @endorsement = Endorsement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @endorsement }
    end
  end

  # GET /endorsements/new
  # GET /endorsements/new.xml
  def new
    @endorsement = Endorsement.new
    @endorsement.user_id = params[:user_requesting_endorse_id]
    @endorsement.endorser_id = current_user.id
    @endorsement.job_title = "Your job title"
    @endorsement.company_name = "Your company name"
    @endorsement.relation_type = "Your relationship type. Manager, Colleague, Friend, ..."
    @endorsement.years_relation = "How many years have you known each other?"
    @endorsement.description = "Enter your endorsement"
    @user_request_endorse = User.find(@endorsement.user_id)
    @user_request_endorse_name = @user_request_endorse.name rescue nil

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @endorsement }
    end
  end

  # GET /endorsements/1/edit
  def edit
    @endorsement = Endorsement.find(params[:id])
  end

  # POST /endorsements
  # POST /endorsements.xml
  def create
    @endorsement = Endorsement.new(params[:endorsement])

    if @endorsement.save
      redirect_to(user_path(current_user), :notice => 'Endorsement was successfully created.')
    else
      @user_request_endorse_name = User.find(params[:endorsement][:user_id]).name rescue nil
      render :action => "new"
    end
  end

  # PUT /endorsements/1
  # PUT /endorsements/1.xml
  def update
    @endorsement = Endorsement.find(params[:id])

    respond_to do |format|
      if @endorsement.update_attributes(params[:endorsement])
        format.html { redirect_to(@endorsement, :notice => 'Endorsement was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @endorsement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /endorsements/1
  # DELETE /endorsements/1.xml
  def destroy
    @endorsement = Endorsement.find(params[:id])
    @endorsement.destroy

    if request.xhr?
      @endorsements = current_user.endorsements
      render :update do |page|
        page.replace_html "endorsements_index_container", :partial => "my_endorsements"
        page.replace_html "endorsement_counter", @endorsements.size
      end
    end
  end

  def get_endorsement; end

  def send_invite_mail
    valid, error_message = Endorsement.is_message_and_friend_email_valid?(params[:message_subject], params[:message], params[:email])
    if valid.eql?(false)
      flash.now[:notice] = "#{error_message}"
      render :action => "get_endorsement"
    else
      emails = params[:email].split(",")
      emails.each do |email|
        EndorsementMailer.deliver_invite_user_to_endorse_me(params[:message_subject], params[:message], email, current_user)
      end
      redirect_to user_path(current_user)
    end
  end

  private

  def save_user_request_endorse_id
    session[:user_request_endorse_id] = params[:user_requesting_endorse_id] if current_user.blank?
  end
end
