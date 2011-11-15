class StaffingPositionTypesController < ApplicationController
  # GET /staffing_position_types
  # GET /staffing_position_types.xml
  def index
    @staffing_position_types = StaffingPositionType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staffing_position_types }
    end
  end

  # GET /staffing_position_types/1
  # GET /staffing_position_types/1.xml
  def show
    @staffing_position_type = StaffingPositionType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staffing_position_type }
    end
  end

  # GET /staffing_position_types/new
  # GET /staffing_position_types/new.xml
  def new
    @staffing_position_type = StaffingPositionType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staffing_position_type }
    end
  end

  # GET /staffing_position_types/1/edit
  def edit
    @staffing_position_type = StaffingPositionType.find(params[:id])
  end

  # POST /staffing_position_types
  # POST /staffing_position_types.xml
  def create
    @staffing_position_type = StaffingPositionType.new(params[:staffing_position_type])

    respond_to do |format|
      if @staffing_position_type.save
        flash[:notice] = 'StaffingPositionType was successfully created.'
        format.html { redirect_to(@staffing_position_type) }
        format.xml  { render :xml => @staffing_position_type, :status => :created, :location => @staffing_position_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @staffing_position_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /staffing_position_types/1
  # PUT /staffing_position_types/1.xml
  def update
    @staffing_position_type = StaffingPositionType.find(params[:id])

    respond_to do |format|
      if @staffing_position_type.update_attributes(params[:staffing_position_type])
        flash[:notice] = 'StaffingPositionType was successfully updated.'
        format.html { redirect_to(@staffing_position_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @staffing_position_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /staffing_position_types/1
  # DELETE /staffing_position_types/1.xml
  def destroy
    @staffing_position_type = StaffingPositionType.find(params[:id])
    @staffing_position_type.destroy

    respond_to do |format|
      format.html { redirect_to(staffing_position_types_url) }
      format.xml  { head :ok }
    end
  end
end
