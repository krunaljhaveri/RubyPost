RubyPost::Application.routes.draw do

  # Defining routes for RubyPost

  # Route for managing posts
  match 'posts/manage' => 'posts#manage'

  # Route for returning tags
  match 'tags' => 'posts#tags', via: [:get]

  # Route for viewing report
  match 'report' => 'admin#report', via: [:get]

  # Route for managing users
  match 'users/manage' => 'admin#manage', via: [:get]

  # Route for removing users
  match 'users/remove/:id' => 'admin#remove', via: [:delete]

  # Route for updating role
  match 'users/update-role/:id' => 'admin#update_role', via: [:post]

  # Route for home page
  root :to => 'posts#home'

  # Routes for resources
  devise_for :users
  resources :votes
  resources :posts
  resources :categories
  resources :comments, :only => [:create, :destroy, :new, :edit, :update]

end
