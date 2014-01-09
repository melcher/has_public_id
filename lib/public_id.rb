require 'public_id/activerecord/publically_identified_by'
require 'public_id/util'

module PublicId
end

ActiveRecord::Base.send(:include, PublicId::ActiveRecord::PublicallyIdentifiedBy)