class GroupsController < ApplicationController
  def index
     @group = Group.all
  end

  def new

  end

   def show
     @group = Group.find(params[:id])	
   end

  def create
     @group = Group.new(params[:group].permit(:name,:description))
     if @group.save
     redirect_to @group
     else
       render 'new' 
     end
   end

    def destroy
    @group = Group.find(params[:id])
    @group.destroy
 
    redirect_to groups_path
  end
end
