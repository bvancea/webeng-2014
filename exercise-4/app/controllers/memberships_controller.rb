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
    redirect_to @group
  end
end
