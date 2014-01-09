module HasPublicId
  module Util
    def self.generate_random_suffix(length)
      SecureRandom.urlsafe_base64(length)
    end
    def self.generate_prefix(klass, joiner)
      klass.to_s.demodulize.underscore.first(3) + joiner
    end
    def self.new_public_id(klass, options = {})
      length = options[:length] || 10
      prefix = options.fetch(:prefix, generate_prefix(klass, options.fetch(:joiner, '-') ))
      suffix = generate_random_suffix(length)
      "#{prefix ? prefix : ''}#{suffix}"
    end

  end
end
