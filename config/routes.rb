AgentCheck::Application.routes.draw do

  # misc
  get 'current/ip'
  get 'email' => 'email#index'

  # hits
  get 'hits/index' 
  get 'hits/create'
  get 'hits/clear'
  get 'hits/dyn' => 'hits#dynamic_image'
  get 'hits' => 'hits#index'
  post 'hits/delete/:id' => 'hits#destroy'

  # links
  get 'links/index'
  get 'links/' => 'links#index'
  get 'links/follow/:slug' => 'links#follow'
  post 'links/new'

  #Root:
  root :to => 'hits#index'

end
