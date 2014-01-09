module PublicId
  module ActiveRecord
    module InstanceMethods
      def to_param
        self.send(self.class.public_identifier_attribute)
      end
      def public_identifier_attribute
        self.class.public_identifier_attribute
      end
      def initialize_public_id
        self.send(public_identifier_attribute) or
        self.send("#{public_identifier_attribute}=", self.class.new_public_identifier)
      end
    end
    module PublicallyIdentifiedBy
      extend ActiveSupport::Concern
      included do
      end
      module ClassMethods
        def publically_identified_by(attribute_name, *args)
          return if respond_to?(:public_identifier_attribute)
          options = args.extract_options!
          class << self
            attr_accessor :public_identifier_attribute
            # def public_identifier
            #   @public_identifier
            # end
            # def public_identifier=(attribute_name)
            #   @public_identifier = attribute_name
            # end
            def initialize_public_ids!
              self.where(self.public_identifier_attribute => nil).find_each do |obj|
                obj.update_attribute(self.public_identifier_attribute, self.new_public_identifier)
              end
            end
            def find_by_public_id(public_id)
              where(self.public_identifier_attribute => public_id).first
            end
            def new_public_identifier
              while(true)
                new_id = ::PublicId::Util.new_public_identifier(self)
                break unless where(self.public_identifier_attribute => new_id).exists?
              end
              return new_id
            end
          end
          self.public_identifier_attribute = attribute_name
          include ::PublicId::ActiveRecord::InstanceMethods
          after_initialize :initialize_public_id
        end
      end
    end
  end
end