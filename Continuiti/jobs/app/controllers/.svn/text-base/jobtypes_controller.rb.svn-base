class JobtypesController < BaseController
  # GET /jobtypes
  # GET /jobtypes.xml
  
  layout :set_layout
  before_filter :check_admin_access
  
  def index
    @jobtypes = Jobtype.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobtypes }
    end
  end

  # GET /jobtypes/1
  # GET /jobtypes/1.xml
  def show
    @jobtype = Jobtype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @jobtype }
    end
  end

  # GET /jobtypes/new
  # GET /jobtypes/new.xml
  def new
    @jobtype = Jobtype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @jobtype }
    end
  end

  # GET /jobtypes/1/edit
  def edit
    @jobtype = Jobtype.find(params[:id])
  end

  # POST /jobtypes
  # POST /jobtypes.xml
  def create
    @jobtype = Jobtype.new(params[:jobtype])

    respond_to do |format|
      if @jobtype.save
        flash[:notice] = 'Jobtype was successfully created.'
        format.html { redirect_to(@jobtype) }
        format.xml  { render :xml => @jobtype, :status => :created, :location => jobtypes_url }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @jobtype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jobtypes/1
  # PUT /jobtypes/1.xml
  def update
    @jobtype = Jobtype.find(params[:id])

    respond_to do |format|
      if @jobtype.update_attributes(params[:jobtype])
        flash[:notice] = 'Jobtype was successfully updated.'
        format.html { redirect_to(jobtypes_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @jobtype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jobtypes/1
  # DELETE /jobtypes/1.xml
  def destroy
    @jobtype = Jobtype.find(params[:id])
    @jobtype.destroy

    respond_to do |format|
      format.html { redirect_to(jobtypes_url) }
      format.xml  { head :ok }
    end
  end
end
