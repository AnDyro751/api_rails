Rails.application.routes.draw do
  # get 'welcome/index'
  namespace :api , defaults: { format: "json" } do
    namespace :v1 do
      resources :users , only:[:create]
      resources :polls , controller: "my_polls" ,except:[:new,:edit] do
        resources :questions ,except:[:new,:edit]
      end
    end
  end
  root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
