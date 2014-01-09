module PublicId
  module ActiveRecord
    module InstanceMethods
      def to_param
        self.send(public_id_attr)
      end
      def public_id_attr
        self.class.public_id_attr
      end
      def initialize_public_id
        self.send(public_id_attr) or
        self.send("#{public_id_attr}=", self.class.new_public_id)
      end
    end
    module PublicallyIdentifiedBy
      extend ActiveSupport::Concern
      included do
      end
      module ClassMethods
        def has_public_id(attribute_name, *args)
          return if respond_to?(:public_id_attribute)
          options = args.extract_options!
          class << self
            attr_accessor :public_id_attr, :public_id_options
            # def public_identifier
            #   @public_identifier
            # end
            # def public_identifier=(attribute_name)
            #   @public_identifier = attribute_name
            # end
            def initialize_public_ids!
              self.where(self.public_id_attr => nil).find_each do |obj|
                obj.update_attribute(self.public_id_attr, self.new_public_id)
              end
            end
            def find_by_public_id(public_id)
              where(self.public_id_attr => public_id).first
            end
            def new_public_id
              while(true)
                new_id = ::PublicId::Util.new_public_id(self, self.public_id_options)
                break unless where(self.public_id_attr => new_id).exists?
              end
              return new_id
            end
          end
          self.public_id_attr     = attribute_name
          self.public_id_options  = options
          include ::PublicId::ActiveRecord::InstanceMethods
          after_initialize :initialize_public_id
        end
      end
    end
  end
end