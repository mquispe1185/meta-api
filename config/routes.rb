Rails.application.routes.draw do
  namespace :api do
    resources :comercioplanes do 
      put :admin_update, on: :member
    end
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

    put '/habilitar_usuario', to: 'usuarios#habilitar'
    put '/habilitar_comercio', to: 'comercios#habilitar'
    put '/habilitar_promo', to: 'promociones#habilitar'
    put '/add_visita', to: 'comercios#add_visita'
    put '/add_visita_links', to: 'comercios#add_visita_links'
    put '/set_foto', to: 'comercios#set_foto'
    put '/set_foto_promo', to: 'promociones#set_foto'
    get '/miscomercios', to: 'comercios#mis_comercios'
    get '/listacomercios', to: 'comercios#index_inicio'
    get '/mis_comercioplanes', to: 'comercioplanes#mis_planes'
    get '/estadistica_links', to: 'comercios#estadistica_links'
    get '/ver_mas', to: 'comercios#vermas'
    get '/buscar', to: 'comercios#busqueda'
    get '/buscar_rubro', to: 'comercios#busqueda_rubro'
    get '/promos', to: 'promociones#index_main'
    get '/mis_promos', to: 'promociones#mis_promos'
    get '/updatestatuspromo', to: 'promociones#actualizacion_diaria'
    post '/send_consulta', to: 'comercios#enviar_consulta'
    post '/comercioplanes/solicitud_mp', to: 'comercioplanes#solicitud_mp'
    get '/alta_plan_mp', to: 'comercioplanes#alta_plan_mp'
    get '/review_planes', to: 'comercioplanes#review_planes'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
  mount_devise_token_auth_for 'Usuario', at: 'auth', controllers: {
    omniauth_callbacks: "overrides/omniauth_callbacks"
  }
end
