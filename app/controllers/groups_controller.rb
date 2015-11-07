# TODO:
# Pagination on all pages
# Group 'show' page should list all events posted within it (like FB)
# Group 'show' page should give a button to add an event (like FB)

class GroupsController < ApplicationController
 helper_method :is_active?

   def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_login_url # halts request cycle
    end
  end  
  def is_active?(page_name)
        if params[:request_type] == page_name
        "btn btn-default active"
        elsif params[:request_type] != page_name
        "btn btn-info"
        end
   end

  def index
    if params[:request_type ] == 'All'
      @group = Group.all
    elsif params[:request_type] == 'MyGroups'
      @group = current_user.groups
    elsif params[:request_type] == 'Subscribed'
      @group = current_user.subscribed_groups
    else
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
     @group = Group.new(params[:group].permit(:name,:description))
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
