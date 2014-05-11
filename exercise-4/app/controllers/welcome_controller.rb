class WelcomeController < ApplicationController
  def index
    @user=User.find_by_name(session[:logged_user_name])
    if (@user)
      @groups = @user.groups.paginate(page: params[:page])
    end
  end
end
