class SubdomainRequired
  def self.matches?(request)
    request.subdomain.present? && request.subdomain != "www"
  end
end

Rails.application.routes.draw do
  devise_for :users
  resource :account, only: [:new, :create]

  resource :attachment, only: [:new, :create]
  resource :album, only: [:new, :create]

  constraints SubdomainRequired do
    root to: 'dashboards#show', as: 'subdomain_root'
  end

  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
