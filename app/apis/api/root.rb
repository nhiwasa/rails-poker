
module API
  class Root < Grape::API
    mount API::Ver1::Root
    format :json
    prefix 'api'

  end
end