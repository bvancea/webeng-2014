class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def group_owner_user
    if !(session[:logged_user_id]==Group.find(params[:id]).owner_id)
      flash[:error]="User not allowed to perform this action (not the owner of the group). Please sign in!"
      redirect_to controller: 'login', action: 'login'
    end
  end

  def group_member_user
    group=Group.find(params[:id])
    user_ids=Membership.where(group_id: group.id).pluck(:user_id)
    if (!(user_ids.include? session[:logged_user_id]) && !(session[:logged_user_id]==group.owner_id))
      flash[:error]="User not allowed to perform this action (not a member of the group). Please sign in!"
      redirect_to controller: 'login', action: 'login'
    end
  end

  def logged_user
    if !(session[:logged_user_id])
      flash[:error]="User not logged in. Please sign in with valid account!"
      redirect_to controller: 'login', action: 'login'
    end
  end
end
