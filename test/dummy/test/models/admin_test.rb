require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  fixtures :admins
  self.use_transactional_fixtures = true

  test "inherited_class_has_public_id_attr" do
    assert Admin.respond_to?(:public_id_attr)
    assert_equal User.public_id_attr, Admin.public_id_attr
  end

  test "identifier_initializes_from_parent" do
    assert Admin.new.ident.present?, "should have an id when initialized"
    assert_equal Admin.new.ident.first(5), 'user-', "should have a 3 letter prefix from the class name"
  end

  test "identifier_doesnt_change" do
    u = Admin.new
    identifier = u.ident
    u.save!
    u.reload
    assert_equal identifier, u.ident, "doesn't match after create"
    u.save!
    u.reload
    assert_equal identifier, u.ident, "doesn't match after update"
  end
end
