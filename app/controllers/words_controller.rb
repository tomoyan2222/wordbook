class WordsController < ApplicationController
  before_action :authorize, except: [:list, :search]

  PER = 10
  
  def list
    @title = Title.find(params[:id])
    @vocabulary = Vocabulary.where(title_id: @title.id)
  end

  def search
    @category = Category.all
    @titles = Title.all.order(created_at: :desc).page(params[:page]).per(PER)
    if params[:category].present?
      if params[:turn] == "0"
        @titles = Title.where(category_id: params[:category]).page(params[:page]).per(PER)
      elsif params[:turn] == "1"
        @title_count = Title.joins(:bookmarks).group(:title_id).count(:user_id)
        bookmark_ids = Hash[@title_count.sort_by{ | k, v | v }.reverse].keys
        @titles = Title.where(id: bookmark_ids, category_id: params[:category]).order("field(id, #{bookmark_ids.join(',')})").page(params[:page]).per(PER)
      elsif params[:turn] == "2"
        @titles = Title.where(category_id: params[:category]).order(created_at: :desc).page(params[:page]).per(PER)
      end
    end
    if params[:word].present?
      if params[:turn] == "0"
        @titles = Title.where("name like ?", "%#{params[:word]}%").where(category_id: params[:category]).page(params[:page]).per(PER)
      elsif params[:turn] == "1"
        @title_count = Title.joins(:bookmarks).group(:title_id).count(:user_id)
        bookmark_ids = Hash[@title_count.sort_by{ | k, v | v }.reverse].keys
        @titles = Title.where("name like ?", "%#{params[:word]}%").where(id: bookmark_ids, category_id: params[:category]).order("field(id, #{bookmark_ids.join(',')})").page(params[:page]).per(PER)
      elsif params[:turn] == "2"
        @titles = Title.where("name like ?", "%#{params[:word]}%").where(category_id: params[:category]).order(created_at: :desc).page(params[:page]).per(PER)
      end
    end
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
      flash[:danger] = ""
      if word_params[:word].blank?
        flash[:danger] << "word "
      end
      if word_params[:meaning].blank?
        flash[:danger] << "meaning "
      end
      if flash[:danger].present?
        flash[:danger] << "can't be blank."
      end
      if word_params[:word] !=~ /\A[a-zA-Z0-9]+\z/
        flash[:danger] = "please type using only half-width characters"
      end
      if word_params[:word].length > 74
        flash[:danger] = "up to 75 characters"
      end
      if flash[:danger].blank?
        flash[:danger] = "failed to regist... try again"
      end
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

  def destroy
    vocabulary = Vocabulary.find(params[:id])
    title = Title.find(vocabulary.title_id)
    if vocabulary.destroy
      redirect_to list_path(title.id)
    else
      redirect_to list_path(title.id), notice: 'failed to delete... try again'
    end
  end

  def edit_wordbook
    @title = Title.new
    @titles = Title.find(params[:id])
  end

  def update_wordbook
    titles = Title.find(params[:title][:title_id])
    if titles.update(name: title_params[:name], category_id: title_params[:category])
      redirect_to list_path(params[:title][:title_id])
    else
      if title_params[:name].empty?
        flash[:danger] = "name can't be blank. \n"
      end
      if flash[:danger].blank?
        flash[:danger] = "failed to update. try again."
      end
      redirect_to edit_wordbook_path(params[:title][:title_id])
    end
  end

  def destroy_wordbook
    title = Title.find(params[:id])
    if title.destroy
      flash[:notice] = "the wordbook was deleted."
      redirect_to user_word_path(current_user.id)
    else
      flash[:danger] = "failed to delete. try again."
      redirect_to list_path(params[:id])
    end
  end

  private
  def title_params
    params.require(:title).permit(:name, :category, :title_id)
  end

  def word_params
    params.require(:vocabulary).permit(:word, :meaning)
  end
end
