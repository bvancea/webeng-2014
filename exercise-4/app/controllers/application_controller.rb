class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def group_owner_user
    gr_id = nil
    if params[:id]
      gr_id = params[:id]
    else
      if params[:group]
        gr_id = params[:group]
      else
        if session[:current_group]
          gr_id = session[:current_group]
        end
      end
    end
    if gr_id == nil
      flash[:error] = 'Group id not specified!'
      redirect_to controller: 'welcome', action: 'index'
    else
      unless session[:logged_user_id] == Group.find(gr_id).owner_id
        flash[:error] = 'User not allowed to perform this action. Please sign in!'
        redirect_to controller: 'login', action: 'login'
      end
    end
  end

  def group_member_user
    gr_id = nil
    if params[:id]
      gr_id = params[:id]
    else
      if params[:group]
        gr_id = params[:group]
      end
    end
    if gr_id == nil
      flash[:error] = 'Group id not specified!'
      redirect_to controller: 'welcome', action: 'index'
    else
      group = Group.find(gr_id)
      user_ids = Membership.where(group_id: group.id).pluck(:user_id)
      if !(user_ids.include? session[:logged_user_id]) && !(session[:logged_user_id] == group.owner_id)
        flash[:error] = 'User not allowed to perform this action (not a member of the group). Please sign in!'
        redirect_to controller: 'login', action: 'login'
      end
    end
  end

  def logged_user
    unless session[:logged_user_id]
      flash[:error]='User not logged in. Please sign in with valid account!'
      redirect_to controller: 'login', action: 'login'
    end
  end
end
