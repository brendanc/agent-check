AgentCheck::Application.routes.draw do

  get 'current/ip'
  get 'email' => 'email#index'
  get 'hits/index' 
  get 'hits/create'
  get 'hits/clear'
  get 'hits/dyn' => 'hits#dynamic_image'
  get 'hits' => 'hits#index'

  #Root:
  root :to => 'hits#index'

end
