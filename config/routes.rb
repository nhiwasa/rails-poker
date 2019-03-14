Rails.application.routes .draw do
  get '/' => "home#top"
  post '/judge' => "home#judge"

  root to: 'visitors#index'
end
