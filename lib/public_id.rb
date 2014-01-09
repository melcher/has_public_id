require 'public_id/activerecord/has_public_id'
require 'public_id/util'

module PublicId
end

ActiveRecord::Base.send(:include, PublicId::ActiveRecord::PublicallyIdentifiedBy)