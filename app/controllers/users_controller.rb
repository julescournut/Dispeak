class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @Users = User.all
    puts @Users
  end

  def show
    @User = User.find(params[:id])
  end

  def create
    @User = User.new(params.require(:user).permit(:name))
    @User.save
  end
end
