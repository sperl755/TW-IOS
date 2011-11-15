class TimeUnitsController < BaseController
  # GET /time_units
  # GET /time_units.xml
  layout :set_layout
  before_filter :check_admin_access
  
  def index
    @time_units = TimeUnit.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @time_units }
    end
  end

  # GET /time_units/1
  # GET /time_units/1.xml
  def show
    @time_unit = TimeUnit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @time_unit }
    end
  end

  # GET /time_units/new
  # GET /time_units/new.xml
  def new
    @time_unit = TimeUnit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @time_unit }
    end
  end

  # GET /time_units/1/edit
  def edit
    @time_unit = TimeUnit.find(params[:id])
  end

  # POST /time_units
  # POST /time_units.xml
  def create
    @time_unit = TimeUnit.new(params[:time_unit])

    respond_to do |format|
      if @time_unit.save
        flash[:notice] = 'TimeUnit was successfully created.'
        format.html { redirect_to(@time_unit) }
        format.xml  { render :xml => @time_unit, :status => :created, :location => @time_unit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @time_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /time_units/1
  # PUT /time_units/1.xml
  def update
    @time_unit = TimeUnit.find(params[:id])

    respond_to do |format|
      if @time_unit.update_attributes(params[:time_unit])
        flash[:notice] = 'TimeUnit was successfully updated.'
        format.html { redirect_to(@time_unit) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @time_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /time_units/1
  # DELETE /time_units/1.xml
  def destroy
    @time_unit = TimeUnit.find(params[:id])
    @time_unit.destroy

    respond_to do |format|
      format.html { redirect_to(time_units_url) }
      format.xml  { head :ok }
    end
  end
end
