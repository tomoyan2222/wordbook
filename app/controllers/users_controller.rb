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
      user_sign_in(@user)
      redirect_to top_path, notice: "Hi, #{current_user.name}さん" 
    else
      flash[:danger] = 'エラーです。'
      redirect_to sign_up_path
    end
  end

  def sign_in
    @user = User.new
  end

  def sign_in_process
    user = User.find_by(original_name: user_params[:original_name])
    if user
      user_sign_in(user)
      redirect_to top_path, notice: "welcome back #{current_user.name}さん"
    else
      flash[:danger] = "failed to log in..."
      redirect_to sign_in_path
    end
  end

  def sign_out
    user_sign_out
    redirect_to top_path
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
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    upload_file = params[:image]
    if upload_file.present?
      upload_file_name = upload_file.original_filename
      output_dir = Rails.root.join('public', 'user_images')
      output_path = output_dir + upload_file_name
      File.open(output_path, 'w+b') do |f|
        f.write(upload_file.read)
      end
      if @user.update(user_params.merge(image: upload_file_name))
        redirect_to top_path, notice: 'profiles are updated'
      else
        render 'edit'
      end
    else
      if @user.update(user_params)
        redirect_to top_path, notice: 'profiles are updated'
      else
        render 'edit'
      end
    end
  end

  def important
  end

  private
  def user_params
    params.permit(:name, :original_name, :password, :password_confirmation, :profile)
  end
  
end
