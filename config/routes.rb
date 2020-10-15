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

  put '/habilitar_usuario', to: 'usuarios#habilitar'
  put '/habilitar_comercio', to: 'comercios#habilitar'
  put '/add_visita', to: 'comercios#add_visita'
  put '/set_foto', to: 'comercios#set_foto'
  get '/miscomercios', to: 'comercios#mis_comercios'
  get '/listacomercios', to: 'comercios#index_inicio'
  get '/buscar', to: 'comercios#busqueda'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
