Rails.application.routes.draw do
  #word一覧
  get 'words/list/:id', to:'words#list', as: :list
  get 'words/create', to:'words#create', as: :create
  post 'words/create', to:'words#create_title'
  get 'words/add/:id', to:'words#add', as: :add
  post 'words/add/:id', to:'words#add_word'
  get 'words/edit/:id', to:'words#edit', as: :edit
  post 'words/edit/:id', to:'words#edit_word'
  get 'words/delete/:id', to:'words#destroy', as: :delete
  get 'words/list/edit/:id', to:'words#edit_wordbook', as: :edit_wordbook
  post 'words/list/edit/:id', to:'words#update_wordbook'
  get 'words/list/delete/:id', to:'words#destroy_wordbook', as: :destroy_wordbook
  get 'words/search', to:'words#search', as: :word_search
  

  #user一覧
  get '/', to:'users#top', as: :top
  get '/sign_in', to:'users#sign_in', as: :sign_in
  post '/sign_in', to:'users#sign_in_process'
  get '/sign_up', to:'users#sign_up', as: :sign_up
  get '/sign_out', to:'users#sign_out', as: :sign_out
  post '/sign_up', to:'users#sign_up_process'
  get '/users/search', to:'users#search', as: :user_search
  get '/users/profile/:id', to:'users#profile', as: :profile
  get '/users/follow/:id', to:'users#follow', as: :follow
  get '/users/follow/send/:id', to:'users#follow_process', as: :follow_process
  get '/users/follow/unfollow/:id', to:'users#unfollow', as: :unfollow
  get '/users/follower/:id', to:'users#follower'
  get '/users/word/:id', to:'users#word', as: :user_word
  get '/users/likes/:id', to:'users#likes', as: :likes
  get '/users/bookmarks/:id', to:'users#bookmarks', as: :bookmark
  get '/users/edit', to:'users#edit', as: :profile_edit
  post '/users/edit', to:'users#update'
  get '/users/important', to:'users#important', as: :important
  post '/users/important', to:'users#change_pass'
end
