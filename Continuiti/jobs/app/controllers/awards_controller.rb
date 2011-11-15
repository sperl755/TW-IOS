class AwardsController < BaseController

  before_filter :login_required
  before_filter :admin_required, :except => [:show_all_badges, :show_all_available_badges_for_friend, 
    :new_badge_for_friend, :get_a_badge, :share_badge_to_friend, :save_this_badge]
  # GET /awards
  # GET /awards.xml
  def index
    @awards = Award.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @awards }
    end
  end

  # GET /awards/1
  # GET /awards/1.xml
  def show
    @award = Award.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @award }
    end
  end

  # GET /awards/new
  # GET /awards/new.xml
  def new
    @award = Award.new
    @award_types = AwardType.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @award }
    end
  end

  # GET /awards/1/edit
  def edit
    @award = Award.find(params[:id])
    @award_types = AwardType.all
  end

  # POST /awards
  # POST /awards.xml
  def create
    @award = Award.new(params[:award])

    respond_to do |format|
      if @award.save
        flash[:notice] = 'Award was successfully created.'
        format.html { redirect_to(@award) }
        format.xml  { render :xml => @award, :status => :created, :location => @award }
      else
        @award_types = AwardType.all
        format.html { render :action => "new" }
        format.xml  { render :xml => @award.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /awards/1
  # PUT /awards/1.xml
  def update
    @award = Award.find(params[:id])

    respond_to do |format|
      if @award.update_attributes(params[:award])
        flash[:notice] = 'Award was successfully updated.'
        format.html { redirect_to(@award) }
        format.xml  { head :ok }
      else
        @award_types = AwardType.all
        format.html { render :action => "edit" }
        format.xml  { render :xml => @award.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /awards/1
  # DELETE /awards/1.xml
  def destroy
    @award = Award.find(params[:id])
    @award.destroy

    respond_to do |format|
      format.html { redirect_to(awards_url) }
      format.xml  { head :ok }
    end
  end

  def show_all_badges
    @badges = Award.all
    my_badges = []
    current_user.award_users.each{|award_user| my_badges << award_user.award.id}
    @my_badges = my_badges
  end

  def show_all_available_badges_for_friend
    @shareable_badges_for_friends = Award.all(:conditions => "award_type_id = '2'")
  end

  def new_badge_for_friend
    @selected_badge_for_friend = Award.find(params[:badge_id])
  end

  def get_a_badge
    @my_available_badges = Award.all(:conditions => "award_type_id = '1'")
  end

  def share_badge_to_friend
    valid = Award.is_friend_email_valid?(params[:emails])
    unless valid
      flash[:notice] = "Email is not valid!"
      render :action => "new_badge_for_friend"
    else
      emails = params[:emails].split(",")
      emails.each do |email|
        unless current_user.email.eql?(email.strip)
          friend = User.find_by_email(email)
          if friend
            if AwardUser.find_by_user_id_and_award_id(friend.id, params[:badge_id]).blank?
              AwardUser.create({:user_id => friend.id, :award_id => params[:badge_id]})
            end
          end
          badge = Award.find(params[:badge_id])
          EndorsementMailer.deliver_share_the_badge_to_friend(email, current_user, badge)
        end
      end
      redirect_to user_path(current_user)
    end
  end

  def save_this_badge
    if AwardUser.find_by_user_id_and_award_id(current_user.id, params[:badge_id]).blank?
      AwardUser.create({:user_id => current_user.id, :award_id => params[:badge_id]})
    end
    redirect_to user_path(current_user)
  end
end
