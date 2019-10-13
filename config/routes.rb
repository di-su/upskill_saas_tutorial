Rails.application.routes.draw do
 root to: 'pages#home'
 get 'about', to: 'pages#about'
 resources :contacts, only: :create
 get 'contact-us', to: 'contacts#new'
 # get 'contacts/new', to: 'contacts#new'
end
