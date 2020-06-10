class UsersController < ApplicationController
  def top 
    @titles = Title.all.order(created_at: :desc)
  end

  def search
     peaple = User.all.length
     if peaple > 10
       peaple = rand(peaple - 10)
       @users = User.where(id: peaple..Float::INFINITY).limit(10)
       if params[:word].present?
        @users = User.where("original_name like ?", "%#{params[:word]}%")
       end
     else
      @users = User.all.order(id: :desc).limit(10)
     end
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
    if user.authenticate(params[:password])
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
    @user = User.find(params[:id])
    @title = Title.where(user_id: @user.id).length
    @follow = Follow.where(user_id: @user.id).length
    @follower = Follow.where(follow_user_id: @user.id).length
  end

  def follow
    @follows = Follow.where(user_id: current_user.id)
  end

  def follow_process
    follow = Follow.new(user_id: current_user.id, follow_user_id: params[:id])
    follow.save
    redirect_back(fallback_location: follow_path(current_user.id))
  end

  def unfollow
    follow = Follow.find(params[:id])
    follow.destroy
    redirect_back(fallback_location: follow_path(current_user.id))
  end
  
  def follower
    @followers = Follow.where(follow_user_id: current_user.id)
  end

  def word
    @user = User.find(params[:id])
    @title = Title.where(user_id: @user.id)
  end

  def likes
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def bookmarks
    if Bookmark.exists?(title_id: params[:id])
      bookmark = Bookmark.find_by(title_id: params[:id])
      bookmark.destroy
    else
      bookmark = Bookmark.new(user_id: current_user.id, title_id: params[:id])
      bookmark.save
    end
    redirect_to list_path(params[:id])
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
    @user = User.find(current_user.id)
  end
  
  def change_pass
    @user = User.find(current_user.id)
    if @user.authenticate(params[:current_password])
      if @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
        redirect_to top_path, notice: 'password is updated'
      else
        render 'important'
      end
    end
  end

  private
  def user_params
    params.permit(:name, :original_name, :password, :password_confirmation, :profile)
  end
  
end
