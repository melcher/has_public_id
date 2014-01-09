require 'test_helper'

class PublicIdTest < ActiveSupport::TestCase
  fixtures :all
  self.use_transactional_fixtures = true

  test "ActiveRecord::Base responds to publically_identified_by" do
    assert User.respond_to?(:publically_identified_by), "should respond to the method we define"
  end

  test "New users get an ID initialized" do
    assert User.new.ident.present?, "should have an id when initialized"
    assert_equal User.new.ident.first(4), 'use-', "should have a 3 letter prefix from the class name"
  end
  test "Ident should == to_param" do
    u = User.new
    assert_equal u.ident, u.to_param, "should match to_param"
  end
  test "Doesn't change on save, update" do
    u = User.new
    identifier = u.ident
    u.save!
    u.reload
    assert_equal identifier, u.ident, "doesn't match after create"
    u.save!
    u.reload
    assert_equal identifier, u.ident, "doesn't match after update"
  end
  test "Can be looked up by the ident" do
    u = User.create(name: 'joey')
    assert_equal u, User.find_by_public_id(u.to_param), "Can't be looked up by #{u.to_param}"
  end
  test "Initialize all the public id's" do
    # From fixtures...
    assert_equal 3, User.where(ident: nil).count
    User.initialize_public_ids!
    assert_equal User.where(ident: nil).count, 0
  end
end
