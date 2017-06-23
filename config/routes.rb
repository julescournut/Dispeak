Rails.application.routes.draw do
  resources :audio_records
  mount_devise_token_auth_for 'User', at: 'auth'
	
  resources :messages, defaults: { format: :json }
  resources :users, only: [:index, :show, :create]
 	resources :sessions#, :only => [:new, :create, :destroy]
	
	root 'welcome#index'	
	get '/api' => 'application#api', defaults: { format: :json }
	##  match '/login', to 'devise/session#new' , via :get
	
	post ':controller(/:action(/:id(.:format)))'
	get ':controller(/:action(/:id(.:format)))'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
