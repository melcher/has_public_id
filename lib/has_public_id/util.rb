module HasPublicId
  module Util
    DEFAULT_CHAR_SET = (0..9).collect { |i| i.to_s } + ('A'..'Z').to_a + ('a'..'z').to_a
    def self.char_set
      @car_set ||= DEFAULT_CHAR_SET
    end
    def self.generate_random_suffix(length)
      (0...length.to_i).map do |i|
        char_set[SecureRandom.random_number(char_set.length)]
      end.join
    end
    def self.generate_prefix(klass)
      klass.to_s.demodulize.underscore.first(3)
    end
    def self.new_public_id(klass, options = {})
      length = options[:length] || 12
      prefix = options.fetch(:prefix, generate_prefix(klass))
      prefix = nil if !prefix || prefix.empty?
      join_with = options.fetch(:join_with, '-')
      suffix = generate_random_suffix(length)
      [prefix, suffix].compact.join(join_with)
    end

  end
end
