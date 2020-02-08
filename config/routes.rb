Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    resources :categories
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      registrations: 'users/registrations'
    }

    resources :articles do
      collection do
        get :search
      end
    end

    delete 'articles/:id/delete_image_attachment' => 'articles#delete_image_attachment', as: 'delete_image_attachment'

    get 'persons/profile'

    get 'articles/:id/send_to_approve' => 'articles#send_to_approve', as: 'send_to_approve'

    root 'articles#index'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
end
