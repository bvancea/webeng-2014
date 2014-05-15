class ActivitiesController < ApplicationController
  include TwitterHelper

  before_action :group_member_user, only: [:show_all]
  before_action :group_owner_user, only: [:create, :new]
  before_action :logged_user
  before_action :activity_user, only: [:vote, :unvote]

  def new
    @current_group = Group.find(params[:group])
    session[:current_group] = @current_group.id
  end

  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      flash[:success] = 'Activity: ' + @activity.name + ' successfully created.'
    else
      flash[:success] = 'Activity: ' + @activity.name + ' cannot be created.'
    end

    redirect_to action: 'index', controller: 'welcome'
  end


  def edit
    @activity = Activity.find(params[:id])
    @current_group = Group.find(@activity.group_id)
    session[:current_group] = @current_group.id
  end

  def update
    @activity = Activity.update(params[:id], activity_params)

    if @activity
      flash[:success] = 'Activity successfully updated!'
      redirect_to action: 'index', controller: 'welcome'
    else
      flash[:error] = 'Invalid input provided - group edition failed!'
      render 'edit'
    end
  end

  def show_all
    @current_group = Group.find(params[:group])
    session[:current_group] = @current_group.id
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

  private
  def activity_params
    params[:activity][:group_id] = session[:current_group]
    params[:activity][:definitive] ||= false
    params[:activity][:votes] ||= 0
    params.require(:activity).permit(:name, :description, :location, :duration,
                                     :start_date, :image_url, :definitive, :votes, :group_id)

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
