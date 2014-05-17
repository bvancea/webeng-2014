class GroupsController < ApplicationController

  before_action :group_member_user, only: [:show]
  before_action :group_owner_user, only: [:edit, :update, :destroy]
  before_action :logged_user

  def show
    @group = Group.find(params[:id])
    @user_ids = Membership.where(group_id: @group.id).pluck(:user_id)
    @users = User.find(@user_ids)
    @owner = User.find(@group.owner_id)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @user_ids = params[:user_ids]
    @group.owner_id = session[:logged_user_id]
    if @group.save
      if @user_ids
        @user_ids.each do |user_id|
          Membership.create(user_id: user_id, group_id: @group.id)
        end
      end
      flash[:success] = 'Group successfully created!'
      redirect_to action: 'index', controller: 'welcome'
    else
      flash[:error] = 'Invalid input provided - group creation failed!'
      render 'new'
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    flash[:success] = 'Group successfully deleted!'
    redirect_to action: 'index', controller: 'welcome'
  end

  def edit
    @group = Group.find(params[:id])
    @user_ids = Membership.where(group_id: @group.id).pluck(:user_id)
    @users = User.find(@user_ids)
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      Membership.where(group_id: @group.id).destroy_all
      @user_ids = params[:user_ids]
      @user_ids.each do |user_id|
        Membership.create(user_id: user_id, group_id: @group.id)
      end
      flash[:success] = 'Group successfully updated!'
      redirect_to action: 'index', controller: 'welcome'
    else
      @user_ids = Membership.where(group_id: @group.id).pluck(:user_id)
      flash[:error] = 'Invalid input provided - group edition failed!'
      render 'edit'
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :city)
  end

end
