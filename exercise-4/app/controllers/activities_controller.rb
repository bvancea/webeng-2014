class ActivitiesController < ApplicationController
  include TwitterHelper
  include FlickrHelper

  before_action :group_member_user, only: [:show_all]
  before_action :group_owner_user, only: [:create, :new, :make_definitive]
  before_action :logged_user
  before_action :activity_user, only: [:vote, :unvote]

  def new
    @activity = Activity.new
    init_activity(params[:group])
  end

  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      flash[:success] = 'Activity: ' + @activity.name + ' successfully created.'
      redirect_to action: 'index', controller: 'welcome'
    else
      init_activity(session[:current_group])
      flash[:error] = 'Activity: ' + @activity.name + ' cannot be created.'
      render 'new'
    end
  end

  def edit
    @activity = Activity.find(params[:id])
    init_activity(@activity.group_id)
  end

  def update
    @activity = Activity.find(params[:id])
    if @activity.update_attributes(activity_params)
      flash[:success] = 'Activity successfully updated!'
      redirect_to action: 'index', controller: 'welcome'
    else
      init_activity(@activity.group_id)
      flash[:error] = 'Invalid input provided - group edition failed!'
      render 'edit'
    end
  end

  def show_all
    @current_group = Group.find(params[:group])
    session[:current_group] = @current_group.id
  end

  def show
    @activity = Activity.find(params[:activity])
  end

  def vote
    @current_user = User.find(session[:logged_user_id])
    @activity = Activity.find(params[:activity])

    unless @activity.users.include?(@current_user)
      @activity.users << @current_user
      @activity.votes = @activity.votes + 1
      @activity.save
    end

    redirect_to action: 'show_all', :group => @activity.group_id
  end

  def unvote
    @current_user = User.find(session[:logged_user_id])
    @activity = Activity.find(params[:activity])

    if @activity.users.include?(@current_user)
      @activity.users.delete(@current_user)
      @activity.votes = @activity.votes - 1
      #ToDo check for success?
      @activity.save
      #@activity.update_column('votes', @activity.votes)
    end
    redirect_to action: 'show_all', :group => @activity.group_id
  end

  def make_definitive
    @current_user = User.find(session[:logged_user_id])
    @activity = Activity.find(params[:activity])

    if @activity.group.owner_id == @current_user.id and !@activity.definitive
      @activity.definitive = true
      @activity.save
      TwitterHelper::post_tweet build_tweet
    end

    redirect_to action: 'show_all', :group => @activity.group_id
  end

  def search_images_on_flickr
    text = params[:search]
    images = FlickrHelper::search_images(text)
    respond_to do |format|
      format.json  { render :json => images }
    end
  end

  private
  def activity_params
    params[:activity][:group_id] = session[:current_group]
    params[:activity][:definitive] ||= false
    params[:activity][:votes] ||= 0
    params.require(:activity).permit(:name, :description, :location, :duration,
                                     :start_date, :image_url, :definitive, :votes, :group_id)

  end

  def init_activity(group)
    @current_group = Group.find(group)
    session[:current_group] = @current_group.id
  end

  def activity_user
    if Activity.find(params[:activity]).group.memberships.include?(User.find(session[:logged_user_id]))
      flash[:error] = 'User not allowed to perform this action (not a member of the group). Please sign in!'
      redirect_to controller: 'login', action: 'login'
    end
  end

  def build_tweet
    activity_name = @activity.name
    group_name = @activity.group.name
    tweet = "Activity #{activity_name} for group #{group_name} was just made definitive!"
    return tweet
  end
end
