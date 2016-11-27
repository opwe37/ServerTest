Rails.application.routes.draw do
  post  'client/login_request'        => 'client#login_request'
  get   'client/client_join'
  get   'client/update_grade'
  get   'client/add_like_truck'
  get   'client/delete_like_truck'  
  get   'client/like_truck_list'
  get   'client/search_truck'
  get   'client/foodtruck_list'
  post  'client/foodtruck_list'       => 'client#foodtruck_list'
  get   'client/save_review'
  post  'client/save_festival'        => 'client#save_festival'
  get   'client/search_location'
  post  'client/upload_image'         => 'client#upload_image'
  get   'client/change_info'          #=> 'client#change_info'
  get   'client/change_password'      #=> 'client#change_password'
  get   'client/set_location'         #=> 'client#set_location'
  get   'client/is_duplication_check' #=> 'client#is_duplication_check'
  get   'client/update_review'        #=> 'client#update_review'
  get   'client/my_festival_info'     #=> 'client#my_festival_info'
  get   'client/cancle_festival'      #=> 'client#cancle_festival'
  get   'client/save_token'           #=> 'client#save_token'
  
  get   'owner/login_request'
  post  'owner/login_request'           => 'owner#login_request'
  get   'owner/request_festival'
  get   'owner/request_cancle_festival'
  get   'owner/owner_join'
  post  'owner/owner_join'              => 'owner#owner_join'
  get   'owner/truck_info_save'
  post  'owner/add_menu'                => 'owner#add_menu'
  get   'owner/add_menu'
  get   'owner/delete_menu'
  get   'owner/set_open'                #=> 'owner#set_open'
  get   'owner/set_close'               #=> 'owner#set_close'
  get   'owner/changeOwnerInfo'         #=> 'owner#changeOwnerInfo'
  get   'owner/change_password'         #=> 'owner#change_password'
  get   'owner/mytruck_info'            #=> 'owner#mytruck_info'
  get   'owner/selected_festival_info'  #=> 'owner#selected_festival_info'
  
  get   'common/truck_menus'        #=> 'common/truck_menus'
  get   'common/foodtruck_reviews'  #=> 'common/foodtruck_reviews'
  get   'common/festival_info'      #=> 'common/festival_info'
  
  #post 'client/login_request' => 'client#login_request'
  #post 'client/client_join' => 'client#client_join'
  
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
