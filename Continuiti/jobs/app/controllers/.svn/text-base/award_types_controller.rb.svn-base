class AwardTypesController < ApplicationController
  def index
    @award_types = AwardType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @award_types }
    end
  end

  def new
    @award_type = AwardType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @award_type }
    end
  end

  def create
    @award_type = AwardType.new(params[:award_type])

    respond_to do |format|
      if @award_type.save
        flash[:notice] = 'Award type was successfully created.'
        format.html { redirect_to(@award_type) }
        format.xml  { render :xml => @award_type, :status => :created, :location => @award_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @award_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @award_type = AwardType.find(params[:id])
  end

  def update
    @award_type = AwardType.find(params[:id])

    respond_to do |format|
      if @award_type.update_attributes(params[:award_type])
        flash[:notice] = 'Award type was successfully updated.'
        format.html { redirect_to(@award_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @award_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @award_type = AwardType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @award_type }
    end
  end

  def destroy
    @award_type = AwardType.find(params[:id])
    @award_type.destroy

    respond_to do |format|
      format.html { redirect_to(award_types_url) }
      format.xml  { head :ok }
    end
  end

end
