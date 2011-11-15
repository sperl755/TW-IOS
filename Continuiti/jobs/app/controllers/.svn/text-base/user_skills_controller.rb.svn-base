class UserSkillsController < ApplicationController
  # GET /user_skills
  # GET /user_skills.xml
  before_filter :check_ownership, :only => [:edit, :update, :destroy, :new, :create]
  def index
    @user_skills = UserSkill.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_skills }
    end
  end

  # GET /user_skills/1
  # GET /user_skills/1.xml
  def show
    @user_skill = UserSkill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_skill }
    end
  end

  # GET /user_skills/new
  # GET /user_skills/new.xml
  def new
    if request.xhr?
      render :update do |page|
        page.replace_html "add_skill_form", :partial => "form"
        page << "$('add_new_skill_ajax_loader').hide()"
      end
    end
  end

  # GET /user_skills/1/edit
  def edit
    @user_skill = UserSkill.find(params[:id])
    if request.xhr?
      render :update do |page|
        page.replace_html "add_skill_form", :partial => "edit"
        page << "$('add_new_skill_ajax_loader').hide()"
      end
    end
  end

  # POST /user_skills
  # POST /user_skills.xml
  def create
    valid = true
    render :update do |page|
      if request.xhr?
        currently_title_skill = []
        params[:user_skill].each do |key, value|
          skill = Skill.find_by_name(params["user_skill_#{key}_title".to_sym])
          params[:user_skill][key.to_s][:skill_id] = if skill.blank?
            -1
          else
            skill.id
          end
          @user_skill = UserSkill.new(params[:user_skill][key.to_s])
          @user_skill.user_id = current_user.id
          unless @user_skill.valid?
            valid = false
            if @user_skill.errors.to_a.map{|err| err[0]}.include?("title")
              page << "$('user_skill_title_been_taken_#{key}').show()"
              page << "$('user_skill_title_cant_be_blank_#{key}').hide()"
            elsif @user_skill.errors.to_a.map{|err| err[0]}.include?("skill_id")
              page << "$('user_skill_title_been_taken_#{key}').show()"
              page << "$('user_skill_title_cant_be_blank_#{key}').hide()"
            end
          else
            if currently_title_skill.include?(params["user_skill_#{key}_title".to_sym])
              valid = false
              page << "$('user_skill_title_been_taken_#{key}').show()"
              page << "$('user_skill_title_cant_be_blank_#{key}').hide()"
            else
              page << "$('user_skill_title_been_taken_#{key}').hide()"
              page << "$('user_skill_title_cant_be_blank_#{key}').hide()"
            end
            currently_title_skill << params[:user_skill][key.to_s][:title]
          end
        end
      end

      if valid
        params[:user_skill].each do |key, value|
          @skills = []
          skill = Skill.find_or_create_by_name(params["user_skill_#{key}_title".to_sym])
          params[:user_skill][key.to_s][:skill_id] = skill.id
          @user_skill = UserSkill.new(params[:user_skill][key.to_s])
          @user_skill.user_id = current_user.id

          @user_skill.save
          if request.xhr?
            @skills << @user_skill
            page.insert_html :top, "skill_index_container", :partial => "index"
            page << "$(\"add_skill_form\").innerHTML = \"\""
          end
        end
      end
    end
  end

  # PUT /user_skills/1
  # PUT /user_skills/1.xml
  def update
    @user_skill = UserSkill.find(params[:id])
    skill = Skill.find_or_create_by_name(params["user_skill_0_title".to_sym])
    params[:user_skill][:skill_id] = skill.id

    if @user_skill.update_attributes(params[:user_skill])
      if request.xhr?
        @skills = UserSkill.all(:conditions => "user_id = '#{current_user.id}'", :order => "created_at DESC")
        render :update do |page|
          page.replace_html "skill_index_container", :partial => "index", :locals => {:skills => @skills}
          page << "$(\"add_skill_form\").innerHTML = \"\""
        end
      end
    else
      if request.xhr?
        render :update do |page|
          if @user_skill.errors.to_a.map{|err| err[0]}.include?("title") or
              @user_skill.errors.to_a.map{|err| err[0]}.include?("skill_id")
            page << "$('user_skill_title_been_taken_0').show()"
            page << "$('user_skill_title_cant_be_blank_0').hide()"
          end
        end
      end
    end
  end

  # DELETE /user_skills/1
  # DELETE /user_skills/1.xml
  def destroy
    @user_skill = UserSkill.find(params[:id])
    @user_skill.destroy
    if request.xhr?
      @skills = UserSkill.all(:conditions => "user_id = '#{current_user.id}'", :order => "created_at DESC")
      render :update do |page|
        page.replace_html "skill_index_container", :partial => "index", :locals => {:skills => @skills}
      end
    end
  end

  def search_skill
    @suggested_skills = Skill.all(:conditions => "name LIKE '%#{params[:query]}%'")
    respond_to do |format|
      format.json
    end
  end

  private

  def check_ownership
    if check_current_user && !admin?
      id = params[:id].to_i
      if !id.blank? && id > 0
        object = UserSkill.find_by_id(params[:id])
        if object.user_id != current_user.id
          flash[:notice] = "You are not allowed for the requested page."
          redirect_to home_url
        end
      end
    end
  end
end
