class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    request_type = (params[:request_type].blank? || params[:request_type].length == 0) ? "AllGroups" : params[:request_type]

    if request_type == 'AllGroups'
      @group = Group.all

   elsif request_type == 'Subscribed'
      @group = current_user.subscribed_groups

    elsif request_type == 'MyCreated'
      @group = current_user.groups

    end
  end

  def new
     @group = Group.new
  end

  def edit
     @group = Group.find(params[:id])
   end

   def show
     @group = Group.find(params[:id])	
   end

  def create
     @group = Group.new(params[:group].permit(:name,:description,:image_attachment))     
     @group.user_id = current_user.id
     if @group.save
     redirect_to @group
     else
       render 'new' 
     end
   end

  def update
    @group = Group.find(params[:id])
    if @group.update((params[:group].permit(:name,:description)))
     redirect_to @group
    else
     render 'edit'
    end
  end

  # Add or remove subscription of user for a group
  # User can subscribe to any group.
  def subscribe
    group = Group.find(params[:id])

    if params[:perform] == 'Join'
      current_user.subscribed_groups << group
      group.subscribers << current_user

    elsif params[:perform] == 'Remove'
      current_user.subscribed_group_ids.delete(group.id)
      group.subscriber_ids.delete(current_user.id)
    end

    current_user.save!
    group.save!

    redirect_to groups_path(request_type: params[:request_type])
  end

    def destroy
    @group = Group.find(params[:id])
    @group.destroy
 
    redirect_to groups_path
  end
end
