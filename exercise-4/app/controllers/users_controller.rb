class UsersController < ApplicationController

  def new
  end

  def index
    @users=User.paginate(page: params[:page], per_page: 2)
  end

  def create
    @user = User.new(user_params)

    if (@user.save)
      puts "*************Successfully saved." + @user.username
    else
      puts "*************Not saved! :("
    end

    redirect_to @user
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
