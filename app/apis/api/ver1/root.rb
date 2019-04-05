module API
  module Ver1
    class Root < Grape::API

      # これでdomain/api/v1でアクセス出来るようになる。
      version 'v1', using: :path
      format :json
      formatter :json, Grape::Formatter::Jbuilder




      route :any, '*path' do
        error!({error: [{msg: "不正なURLです。"}]},404)
      end


      rescue_from Grape::Exceptions::Base do
        error!({error: [{msg: "不正なリクエストです。"}]},400)
      end

      rescue_from :all do
        error!({error: [{msg: "予測しないエラーです。"}]}, 500)
      end



      mount API::Ver1::Judge




    end
  end
end