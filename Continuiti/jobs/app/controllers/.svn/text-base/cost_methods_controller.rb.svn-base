class CostMethodsController < BaseController
  # GET /cost_methods
  # GET /cost_methods.xml
  layout :set_layout
  before_filter :check_admin_access
  
  def index
    @cost_methods = CostMethod.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cost_methods }
    end
  end

  # GET /cost_methods/1
  # GET /cost_methods/1.xml
  def show
    @cost_method = CostMethod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cost_method }
    end
  end

  # GET /cost_methods/new
  # GET /cost_methods/new.xml
  def new
    @cost_method = CostMethod.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cost_method }
    end
  end

  # GET /cost_methods/1/edit
  def edit
    @cost_method = CostMethod.find(params[:id])
  end

  # POST /cost_methods
  # POST /cost_methods.xml
  def create
    @cost_method = CostMethod.new(params[:cost_method])

    respond_to do |format|
      if @cost_method.save
        flash[:notice] = 'CostMethod was successfully created.'
        format.html { redirect_to(@cost_method) }
        format.xml  { render :xml => @cost_method, :status => :created, :location => @cost_method }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cost_method.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cost_methods/1
  # PUT /cost_methods/1.xml
  def update
    @cost_method = CostMethod.find(params[:id])

    respond_to do |format|
      if @cost_method.update_attributes(params[:cost_method])
        flash[:notice] = 'CostMethod was successfully updated.'
        format.html { redirect_to(@cost_method) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cost_method.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cost_methods/1
  # DELETE /cost_methods/1.xml
  def destroy
    @cost_method = CostMethod.find(params[:id])
    @cost_method.destroy

    respond_to do |format|
      format.html { redirect_to(cost_methods_url) }
      format.xml  { head :ok }
    end
  end
end
