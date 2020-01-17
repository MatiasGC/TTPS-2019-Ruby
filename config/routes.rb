Rails.application.routes.draw do
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	get 'productos/', to: 'products#index'

	get 'productos/scarce', to: 'products#scarceProducts'

	get 'productos', to: 'products#allProducts'

  	get 'productos/:codigo', to: 'products#show'

  	get 'productos/:codigo/items', to: 'products#showItems'

  	post 'productos/:codigo/items', to: 'products#create'

  	delete 'productos/:id', to: 'product#destroy'


end
