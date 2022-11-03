





Rails.application.routes.draw do
  resources :bugs, path_names: {edit: "edit/:edit_type/:project_id"}
  resources :projects
  namespace :functionality do
    resources :users, path_names: {new: "new/:creator_id/:project_id"}
  end
  devise_for :users
  get "/user" => "main#index", :as => :user_root
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "main#index"
end
