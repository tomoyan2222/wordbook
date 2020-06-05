class WordsController < ApplicationController
  def list
    @title = Title.find(params[:id])
    @vocabulary = Vocabulary.where(title_id: @title.id)
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
    @title = Title.find(params[:id])
    @vocabulary = Vocabulary.new
  end

  def add_word
    @vocabulary = Vocabulary.new(word: word_params[:word], meaning: word_params[:meaning], title_id: params[:vocabulary][:title_id])
    if @vocabulary.save
      redirect_to list_path(params[:vocabulary][:title_id])
    else
      flash[:danger] = "failed to regist... try again"
      redirect_to add_path(params[:vocabulary][:title_id])
    end
  end

  def edit
    @vocabulary = Vocabulary.new
    @word = Vocabulary.find(params[:id])
    @title = Title.find(@word.id)
  end

  def edit_word
    @vocabulary = Vocabulary.find(params[:vocabulary][:vocabulary_id])
    @title = Title.find(@vocabulary.title_id)
    if @vocabulary.update(word: word_params[:word], meaning: word_params[:meaning])
      redirect_to list_path(@title.id)
    else
      redirect_to edit_word_path(@title.id)
    end
  end

  private
  def title_params
    params.require(:title).permit(:name, :category)
  end

  def word_params
    params.require(:vocabulary).permit(:word, :meaning)
  end
end
