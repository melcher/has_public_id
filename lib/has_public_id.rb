require 'has_public_id/activerecord/mixin'
require 'has_public_id/util'

module HasPublicId
end

ActiveRecord::Base.send(:include, HasPublicId::ActiveRecord::Mixin)
