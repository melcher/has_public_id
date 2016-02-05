require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  self.use_transactional_fixtures = true

  test "identifier_initializes" do
    assert User.new.ident.present?, "should have an id when initialized"
    assert_equal User.new.ident.first(5), 'user-', "should have a 3 letter prefix from the class name"
  end

  test "identifier_doesnt_change" do
    u = User.new
    identifier = u.ident
    u.save!
    u.reload
    assert_equal identifier, u.ident, "doesn't match after create"
    u.save!
    u.reload
    assert_equal identifier, u.ident, "doesn't match after update"
  end

  test "to_param_matches_identifier" do
    u = User.new
    assert_equal u.ident, u.to_param, "should match to_param"
  end

  test "new_public_id" do
    pid = User.new_public_id
    assert pid.starts_with?('user-'), 'has the right prefix'
    assert_equal  4 + 1 + 12, pid.length, 'has the right length'
  end

  test "find_by_public_id" do
    u = User.create(name: 'joey')
    assert_equal u, User.find_by_public_id(u.to_param), "Can't be looked up by #{u.to_param}"
    assert_nil User.find_by_public_id('bad_key'), 'returns nil if not found'
  end

  test "find_by_public_id!" do
    u = User.create(name: 'joey')
    assert_equal u, User.find_by_public_id!(u.to_param), "Can't be looked up by #{u.to_param}"
    assert_raises(ActiveRecord::RecordNotFound){ User.find_by_public_id!('bad_key') }
    assert_raises(ActiveRecord::RecordNotFound){ User.find_by_public_id!(nil) }
  end

  test "initialize_public_ids!" do
    # From fixtures...
    assert_equal 3, User.where(ident: nil).count
    User.initialize_public_ids!
    assert_equal User.where(ident: nil).count, 0
  end

  test "use group-by sql" do
    grouped = User.select('name, count(name) as count').group('name')
    assert_equal grouped.length, User.all.map(&:name).count
    assert_equal grouped.map(&:name).sort, User.all.map(&:name).uniq.sort
    grouped.map(&:count).each do |count|
      assert_equal count, 1
    end
    assert_equal grouped[0].has_attribute?(:ident), false
  end

end
