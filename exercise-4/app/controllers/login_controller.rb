class LoginController < ApplicationController

  def login

  end

  def authenticate
    @user = User.find_by_username(params[:login][:username])

    if (@user != nil && @user.password == params[:login][:password])
      session[:logged_user_name] = @user.name
      session[:logged_user_id] = @user.id
      redirect_to action: 'index', controller: 'welcome'
    else
      redirect_to action: 'login', :alert => "Wrong username or password!"
    end
  end
end
