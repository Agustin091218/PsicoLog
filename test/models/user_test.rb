require "test_helper"

class UserTest < ActiveSupport::TestCase
  def valid_attributes
    {
      first_name: "Juan",
      last_name: "Perez",
      email: "juan@example.com",
      password: "secret123",
      password_confirmation: "secret123"
    }
  end

  test "creates a valid user" do
    user = User.new(valid_attributes)
    assert user.valid?
  end

  test "generates a uuid as id" do
    user = User.create!(valid_attributes)
    assert_match(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/, user.id)
  end

  test "requires first_name" do
    user = User.new(valid_attributes.except(:first_name))
    assert_not user.valid?
    assert_includes user.errors[:first_name], "can't be blank"
  end

  test "requires last_name" do
    user = User.new(valid_attributes.except(:last_name))
    assert_not user.valid?
    assert_includes user.errors[:last_name], "can't be blank"
  end

  test "requires email" do
    user = User.new(valid_attributes.except(:email))
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "requires password" do
    user = User.new(valid_attributes.except(:password, :password_confirmation))
    assert_not user.valid?
    assert_includes user.errors[:password], "can't be blank"
  end

  test "email must be unique" do
    User.create!(valid_attributes)
    duplicate = User.new(valid_attributes.merge(first_name: "Otro"))
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
  end

  test "email uniqueness is case insensitive" do
    User.create!(valid_attributes)
    duplicate = User.new(valid_attributes.merge(email: "JUAN@EXAMPLE.COM"))
    assert_not duplicate.valid?
  end

  test "phone is optional" do
    user = User.new(valid_attributes.merge(phone: nil))
    assert user.valid?
  end

  test "soft_delete marks deleted_at" do
    user = User.create!(valid_attributes)
    user.soft_delete
    assert user.deleted?
    assert_not_nil user.deleted_at
  end

  test "active scope hides soft deleted users" do
    user = User.create!(valid_attributes)
    user.soft_delete
    assert_nil User.active.find_by(id: user.id)
    assert_not_nil User.deleted.find_by(id: user.id)
  end

  test "restore clears deleted_at" do
    user = User.create!(valid_attributes)
    user.soft_delete
    user.restore
    assert_not user.deleted?
    assert_nil user.deleted_at
  end

  test "restored user appears in active scope again" do
    user = User.create!(valid_attributes)
    user.soft_delete
    user.restore
    assert_not_nil User.active.find_by(id: user.id)
  end