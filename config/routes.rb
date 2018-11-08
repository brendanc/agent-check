AgentCheck::Application.routes.draw do

  get "current/ip"

  get 'hits/index'
  get 'hits/create'
  get 'hits/clear'
  get 'hits' => 'hits#index'

  #Root:
  root :to => "hits#index"

end
