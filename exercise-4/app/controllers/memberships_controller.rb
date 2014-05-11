class MembershipsController < ApplicationController
  def create(user, group)
    @membership=Membership.new
    @membership.group_id=group.id;
    @membership.user_id=user.id;
    @membership.save
  end

  def destroy
    Membership.where(group_id: params[:group], user_id: params[:user]).destroy_all()
    @group=Group.find(params[:group])
    if (params[:id]==params[:group])
      redirect_to @group
    else
      redirect_to action: 'index', controller: 'welcome'
    end
  end
end
