class PeoplesController < ApplicationController
  def index
    @people = User.all
  end
end
