class WelcomeController < ApplicationController
  def index
    @user=User.find_by_name(session[:logged_user_name])
    if (@user)
      @groups = @user.groups.paginate(page: params[:group_page],:per_page => 20)
      @memberships=@user.memberships.paginate(page: params[:membership_page],:per_page => 20)
      @mgroups=Group.find(@memberships.pluck(:group_id));
    end
  end
end
