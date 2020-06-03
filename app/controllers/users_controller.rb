class UsersController < ApplicationController
  def top
  end

  def search
  end

  def sign_up
    @user = User.new
  end

  def sign_up_process
    @user = User.new(user_params)
    if @user.save
      redirect_to top_path
    else
      render :sign_up
    end
  end

  def sign_in
  end

  def profile
  end

  def follow
  end

  def follower
  end

  def word
  end

  def likes
  end

  def edit
  end

  def important
  end

  private
  def user_params
    params.permit(:name, :original_name, :password, :password_confirmation)
  end
  
end
