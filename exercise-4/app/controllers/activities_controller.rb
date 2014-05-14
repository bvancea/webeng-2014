class ActivitiesController < ApplicationController

  def new

    @current_group = Group.find(params[:group])
    session[:current_group] = @current_group.id

  end

  def create
    @activity = Activity.new(activity_params)

    if (@activity.save)
      puts "*************Successfully saved activity." + @activity.name
    end

    redirect_to action: 'index', controller: 'welcome'
  end

  def show_all
    @current_group = Group.find(params[:group])
    session[:current_group] = @current_group.id
  end

  def vote
    @current_user = User.find(session[:logged_user_id])
    @activity = Activity.find(params[:activity])

    if !(@activity.users.include?(User.find(@current_user)))
      @activity.users << User.find(@current_user)
      @activity.votes = @activity.votes + 1
      @activity.update_column('votes', @activity.votes)
      redirect_to action: 'show_all', :group => @activity.group_id
    else
      redirect_to action: 'show_all', :group => @activity.group_id
    end
  end

  def unvote
    @current_user = User.find(session[:logged_user_id])
    @activity = Activity.find(params[:activity])

    if (@activity.users.include?(User.find(@current_user)))
      @activity.users.delete(User.find(@current_user))
      @activity.votes = @activity.votes - 1
      @activity.update_column('votes', @activity.votes)
      redirect_to action: 'show_all', :group => @activity.group_id
    else
      redirect_to action: 'show_all', :group => @activity.group_id
    end
  end

  private
  def activity_params
    params[:activity][:group_id] = session[:current_group]
    params[:activity][:definitive] = false
    params[:activity][:votes] = 0
    params.require(:activity).permit(:name, :description, :location, :duration,
                                     :start_date, :image_url, :definitive, :votes, :group_id)
  end
end
