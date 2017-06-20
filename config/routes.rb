Rails.application.routes.draw do
	
  resources :messages
  resources :users, only: [:index, :show, :create]
 	resources :sessions, :only => [:new, :create, :destroy]
	
	root 'welcome#index'	
	get '/api' => 'application#api', defaults: { format: :json }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
