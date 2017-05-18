Rails.application.routes.draw do


  resources :users, only: [:index, :show, :create]
 	resources :sessions, :only => [:new, :create, :destroy]
	
  get 'signin' => 'sessions#new'
  get '/signout' => 'sessions#destroy'
	get '/signup' => 'users#new' # TODO JULES : mettre ton vrai lien d'inscription #!/login
	
	root 'welcome#index'	
	get '/api' => 'application#api', defaults: { format: :json }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
