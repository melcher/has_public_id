require 'test_helper'

class HasPublicIdTest < ActiveSupport::TestCase
  test "Mixin" do
    assert ActiveRecord::Base.respond_to?(:has_public_id), "should respond to the method we define"
  end

end

class HasPublicId::UtilTest < ActiveSupport::TestCase
  test "char_set.length" do
    assert_equal 62, HasPublicId::Util.char_set.length
  end

  test "generate_random_suffix" do
    keys = {}
    1000.times do |i|
      # 62 ^ 10 possibiliities
      suffix = HasPublicId::Util.generate_random_suffix(10)
      assert_nil keys[suffix], "#{suffix} is a duplicate!"
      keys[suffix] = i
    end
  end
  test "generate_random_suffix(length)" do
    assert_equal 10, HasPublicId::Util.generate_random_suffix(10).length
    assert_equal 15, HasPublicId::Util.generate_random_suffix(15).length
  end
  test "new_public_id(with_prefix)" do
    key = HasPublicId::Util.new_public_id(User, length: 10, prefix: 'user')
    assert_equal('user-', key.first(5), "prefix option")
  end
  test "new_public_id(with_false_prefix)" do
    key = HasPublicId::Util.new_public_id(User, length: 10, prefix: false)
    assert key.match(/^[a-zA-Z0-9]{10}$/), "#{key} doesn't match 10 random alphanumerics"
    assert_equal(10, key.length, "prefix: false")
  end
  test "new_public_id(with_nil_prefix)" do
    key = HasPublicId::Util.new_public_id(User, length: 10, prefix: nil)
    assert key.match(/^[a-zA-Z0-9]{10}$/), "#{key} doesn't match 10 random alphanumerics"
    assert_equal(10, key.length, "prefix: nil")
  end
  test "new_public_id(with_blank_prefix)" do
    key = HasPublicId::Util.new_public_id(User, length: 10, prefix: '')
    assert key.match(/^[a-zA-Z0-9]{10}$/), "#{key} doesn't match 10 random alphanumerics"
    assert_equal(10, key.length, "prefix: ''")
  end
  test "new_public_id(with_join_with)" do
    key = HasPublicId::Util.new_public_id(User, length: 10, join_with: '_')
    assert_equal('use_', key.first(4))
  end
end
