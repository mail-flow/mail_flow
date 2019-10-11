MailFlow::Engine.routes.draw do
  resources :flows, only: [:index]

  scope format: true, constraints: { format: 'json' } do
    resources :flows, except: [:new, :edit]
  end
end
