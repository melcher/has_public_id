class User < ActiveRecord::Base
  has_public_id :ident, prefix: 'user'
end
