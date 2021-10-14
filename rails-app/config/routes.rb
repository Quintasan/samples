Rails.application.routes.draw do
  resources :teas, defaults: { format: :json }
end
