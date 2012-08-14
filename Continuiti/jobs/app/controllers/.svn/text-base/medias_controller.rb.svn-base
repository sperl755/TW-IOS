class MediasController < BaseController
  before_filter :load_media, :only => [:edit, :update, :destroy]
  before_filter :login_required, :only => [:new, :create, :edit, :update, :destroy]
  # Controller for personal custom multimedia

  def index
    @medias = Media.find(:all)
  end

  def show
    @media = Media.find(params[:id])
  end

  def new
    @media = Media.new
  end

  def edit
  end

  def create
    @media = Media.new(params[:media].merge(:user_id => current_user))

    respond_to do |format|
      if @media.save
        flash[:notice] = 'Media was successfully created.'
        format.html { redirect_to(@media) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @media.update_attributes(params[:media])
        flash[:notice] = 'Media was successfully updated.'
        format.html { redirect_to(@media) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @media.destroy
    redirect_to(medias_url)
  end
  
  private
    def load_media
      @media = Media.find(params[:id])
      redirect_to user_medias_path(params[:user_id]) if @media.user_id != current_user.id
    end
  
end
