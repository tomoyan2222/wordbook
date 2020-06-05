class WordsController < ApplicationController
  def list
    @title = Title.find(params[:id])
  end

  def search
  end

  def create
    @title = Title.new
  end

  def create_title
    category = Category.find(title_params[:category].to_i)
    @title = Title.new(name: title_params[:name], category_id: category.id, user_id: current_user.id)
    if @title.save
      redirect_to list_path(@title.id) and return
    else
      render 'create'
    end
  end

  def add
  end

  def edit
  end

  private
  def title_params
    params.require(:title).permit(:name, :category)
  end
end
