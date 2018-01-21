class SubdomainRequired
  def self.matches?(request)
    request.subdomain.present? && request.subdomain != "www"
  end
end

Rails.application.routes.draw do
  devise_for :users
  resource :account, only: [:new, :create]

  resource :attachment, only: [:new, :create]
  get 'attachment/:id', to: 'attachments#show', as: 'attachment_show'
  resource :album, only: [:new, :create]
  get 'album/:id', to: 'albums#show', as: 'album_show'

  constraints SubdomainRequired do
    root to: 'dashboards#show', as: 'subdomain_root'
  end

  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
