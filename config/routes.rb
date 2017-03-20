Rails.application.routes.draw do
  scope '/update' do
    put '/name/:id/:name' => 'blinkbox_files#update_name'

    put '/date/:id/:date' => 'blinkbox_files#update_expiring_date'

    get '/:id' => 'blinkbox_files#show'
  end
  resources :blinkbox_files, :only => [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
