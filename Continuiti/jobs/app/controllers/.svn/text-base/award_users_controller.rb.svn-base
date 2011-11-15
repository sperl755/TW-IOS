class AwardUsersController < BaseController
  # GET /award_users
  # GET /award_users.xml
  before_filter :login_required
  before_filter :admin_required

  def index
    @award_users = AwardUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @award_users }
    end
  end

  # GET /award_users/1
  # GET /award_users/1.xml
  def show
    @award_user = AwardUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @award_user }
    end
  end

  # GET /award_users/new
  # GET /award_users/new.xml
  def new
    @award_user = AwardUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @award_user }
    end
  end

  # GET /award_users/1/edit
  def edit
    @award_user = AwardUser.find(params[:id])
  end

  # POST /award_users
  # POST /award_users.xml
  def create
	puts 'params[:award_user]'
	puts 'params[:award_user]'
	puts 'params[:award_user]'
	puts params[:award_user]
    @award_user = AwardUser.new(params[:award_user])

    respond_to do |format|
      if @award_user.save
        flash[:notice] = 'AwardUser was successfully created.'
        format.html { redirect_to(@award_user) }
        format.xml  { render :xml => @award_user, :status => :created, :location => @award_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @award_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /award_users/1
  # PUT /award_users/1.xml
  def update
    @award_user = AwardUser.find(params[:id])

    respond_to do |format|
      if @award_user.update_attributes(params[:award_user])
        flash[:notice] = 'AwardUser was successfully updated.'
        format.html { redirect_to(@award_user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @award_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /award_users/1
  # DELETE /award_users/1.xml
  def destroy
    @award_user = AwardUser.find(params[:id])
    @award_user.destroy

    respond_to do |format|
      format.html { redirect_to(award_users_url) }
      format.xml  { head :ok }
    end
  end
end
