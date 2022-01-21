class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all.order('id')
  end

  def show
    @user = User.find(params[:id])
  end
end