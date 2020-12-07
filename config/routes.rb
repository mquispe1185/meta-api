Rails.application.routes.draw do
  resources :comercioplanes
  resources :tipo_servicios
  resources :formapagos
  resources :promociones
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
  put '/habilitar_promo', to: 'promociones#habilitar'
  put '/add_visita', to: 'comercios#add_visita'
  put '/set_foto', to: 'comercios#set_foto'
  put '/set_foto_promo', to: 'promociones#set_foto'
  get '/miscomercios', to: 'comercios#mis_comercios'
  get '/listacomercios', to: 'comercios#index_inicio'
  get '/ver_mas', to: 'comercios#vermas'
  get '/buscar', to: 'comercios#busqueda'
  get '/buscar_rubro', to: 'comercios#busqueda_rubro'
  get '/promos', to: 'promociones#index_main'
  get '/mis_promos', to: 'promociones#mis_promos'
  get '/updatestatuspromo', to: 'promociones#actualizacion_diaria'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
