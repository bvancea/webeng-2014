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

  private
  def activity_params
    params[:activity][:group_id] = session[:current_group]
    params[:activity][:definitive] = false
    params[:activity][:votes] = 0
    params.require(:activity).permit(:name, :description, :location, :duration,
                                     :start_date, :image_url, :definitive, :votes, :group_id)
  end
end
