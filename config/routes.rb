Rails.application.routes .draw do
  get '/' => "home#top"
  post '/' => "home#judge"

  root to: 'visitors#index'

  mount API::Root => '/api'


end
