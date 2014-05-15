class MembershipsController < ApplicationController

  before_action :group_owner_user, only: [:create]
  before_action :membership_owner_user, only: [:destroy]
  before_action :logged_user

  def create(user, group)
    @membership = Membership.new
    @membership.group_id = group.id;
    @membership.user_id = user.id;
    if @membership.save
      flash[:success] = 'Membership user: ' + User.find(user.id).name +
          ' to group: ' + Group.find(group.id) + ' successfully created!'
    else
      flash[:error] = 'Membership user: ' + User.find(user.id).name +
          ' to group: ' + Group.find(group.id) + ' cannot be created!'
    end
  end

  def destroy
    Membership.where(group_id: params[:group], user_id: params[:user]).destroy_all()
    @group = Group.find(params[:group])
    if params[:id] == params[:group]
      flash[:success] = 'Membership successfully deleted!'
      redirect_to @group
    else
      flash[:success] = 'Group cannot be deleted!'
      redirect_to action: 'index', controller: 'welcome'
    end
  end

  private

  def membership_owner_user
    group=Group.find(params[:group])
    if !(session[:logged_user_id] == params[:user]) && !(session[:logged_user_id] == group.owner_id)
      flash[:error]= 'User not allowed to perform this action (neither owner of the group nor member under action). Please sign in!'
      redirect_to controller: 'login', action: 'login'
    end
  end

end
