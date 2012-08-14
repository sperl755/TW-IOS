class StaffingPositionCategoriesController < ApplicationController
  # GET /staffing_position_categories
  # GET /staffing_position_categories.xml
  def index
    @staffing_position_categories = StaffingPositionCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staffing_position_categories }
    end
  end

  # GET /staffing_position_categories/1
  # GET /staffing_position_categories/1.xml
  def show
    @staffing_position_category = StaffingPositionCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staffing_position_category }
    end
  end

  # GET /staffing_position_categories/new
  # GET /staffing_position_categories/new.xml
  def new
    @staffing_position_category = StaffingPositionCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staffing_position_category }
    end
  end

  # GET /staffing_position_categories/1/edit
  def edit
    @staffing_position_category = StaffingPositionCategory.find(params[:id])
  end

  # POST /staffing_position_categories
  # POST /staffing_position_categories.xml
  def create
    @staffing_position_category = StaffingPositionCategory.new(params[:staffing_position_category])

    respond_to do |format|
      if @staffing_position_category.save
        flash[:notice] = 'StaffingPositionCategory was successfully created.'
        format.html { redirect_to(@staffing_position_category) }
        format.xml  { render :xml => @staffing_position_category, :status => :created, :location => @staffing_position_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @staffing_position_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /staffing_position_categories/1
  # PUT /staffing_position_categories/1.xml
  def update
    @staffing_position_category = StaffingPositionCategory.find(params[:id])

    respond_to do |format|
      if @staffing_position_category.update_attributes(params[:staffing_position_category])
        flash[:notice] = 'StaffingPositionCategory was successfully updated.'
        format.html { redirect_to(@staffing_position_category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @staffing_position_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /staffing_position_categories/1
  # DELETE /staffing_position_categories/1.xml
  def destroy
    @staffing_position_category = StaffingPositionCategory.find(params[:id])
    @staffing_position_category.destroy

    respond_to do |format|
      format.html { redirect_to(staffing_position_categories_url) }
      format.xml  { head :ok }
    end
  end
end
