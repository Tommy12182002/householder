Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  get 'home/show'

	root to: "home#index"

	resources :users do
        # 年・月・週単位の家計簿の表示対応
		get 'journals/:year' => 'journals#year',
			:as => :journal_year,
			:param => :year,
			:constraints => {year: /[0-9]+/}

		get 'journals/:year/:month' => 'journals#month',
			:as => :journal_month,
			:param => [:year, :month],
			:constraints => {year: /[0-9]+/, month: /[0-9]+/}

		get 'journals/:year/:month/:week' => 'journals#week',
			as: :journal_week,
			:param => [:year, :month, :week],
			:constraints => {year: /[0-9]+/}

		get 'merge' => 'journals#merge', :as => :merge

		resources :journals, :except => [:show, :update, :edit]
		resource :journals, :only => :update
		resources :categories, :except => :show
		resource :categories
	end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
