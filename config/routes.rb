Rails.application.routes.draw do
  resources :horarios
  resources :rubros
  resources :comercios
  resources :referencias
  resources :localidades
  resources :departamentos
  resources :provincias
  resources :roles
  resources :usuarios
  mount_devise_token_auth_for 'Usuario', at: 'auth', controllers: {
    omniauth_callbacks: "overrides/omniauth_callbacks"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
