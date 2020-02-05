Rails.application.routes.draw do
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	post 'usuarios', to: 'users#create'

  post 'sesiones', to: 'sessions#createSession'

	get 'productos', to: 'products#index'

  get 'productos/:codigo', to: 'products#show'

  get 'productos/:codigo/items', to: 'products#showItems'

  post 'productos/:codigo/items', to: 'products#create'

  get 'reservas', to: 'reservations#index'

  post 'reservas', to: 'reservations#create'

  get 'ventas', to: 'sells#index'

  put 'reservas/:id/vender', to: 'reservations#sell_reservation'

  delete 'reservas/:id', to: 'reservations#destroy'

  get 'reservas/:id', to: 'reservations#show'

  get 'ventas/:id', to: 'sells#show'

  post 'ventas', to: 'sells#create'


end
