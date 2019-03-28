
module API
  class Root < Grape::API
    mount API::Ver1::Root

    route :any, '*path' do
      error! I18n.t('grape.errors.not_found'), 404
    end
  end
end