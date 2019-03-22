Rails.application.routes .draw do
  get '/' => "home#top"
  post '/' => "home#judge"

  root to: 'visitors#index'
end
