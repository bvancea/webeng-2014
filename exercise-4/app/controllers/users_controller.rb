class UsersController < ApplicationController

  before_action :logged_user, only: [:index]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end

  def create
    @user = User.new(user_params)

    if !@user.valid?
      flash[:error] = 'User: ' + @user.username + ' cannot be saved.'
      render 'new'
    else
      @user.password = BCrypt::Password.create(@user.password)
      if @user.save
        flash[:success] = 'User: ' + @user.username + ' successfully saved.'
        redirect_to @user
      else
        flash[:error] = 'User: ' + @user.username + ' cannot be saved.'
        render 'new'
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @groups = @user.groups.paginate(page: params[:page])
  end

  private
    def user_params
      params.require(:user).permit(:name, :username, :password)
    end

end
