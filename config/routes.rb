Rails.application.routes.draw do
  #word一覧
  get 'words/list/:id', to:'words#list'
  get 'words/create', to:'words#create'
  get 'words/add/:id', to:'words#add'
  get 'words/edit/:id', to:'words#edit'
  get 'words/search', to:'words#search'

  #user一覧
  get '/', to:'users#top'
  get '/sign_in', to:'users#sign_in'
  get '/sign_up', to:'users#sign_up'
  get '/users/search', to:'users#search'
  get '/users/profile/:id', to:'users#profile'
  get '/users/follow/:id', to:'users#follow'
  get '/users/follower/:id', to:'users#follower'
  get '/users/word', to:'users#word'
  get '/users/likes', to:'users#likes'
  get '/users/edit/:id', to:'users#edit'
  get '/users/important/:id', to:'users#important'
end
