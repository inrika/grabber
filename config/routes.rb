Rails.application.routes.draw do
  resources :letters do
    collection do
      get :journal
    end
  end

  resources :accounts

#  resources :accounts do
#    resources :letters
#          get :journal
#end

root 'accounts#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
