module UsersHelper
    def user_sign_in(user)
        session[:user_id] = user.id
    end

    def user_sign_out
        session[:user_id] = nil
    end

    def current_user
        if @current_user = User.find_by(id: session[:user_id])
            User.find_by(id: session[:user_id])
        else
            @current_user
        end
    end

    def authorize
        if current_user.blank?
            redirect_to sign_in_path
        end
    end

    def image_url(user)
        if user.image.blank?
            "https://dummyimage.com/200x200/000/fff"
        else
            "/user_images/#{user.image}"
        end
    end
end
