require "test_helper"

class PatientTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(
    first_name: "Test",
    last_name: "User",
    email: "test@example.com",
    password_digest: "123456"
    )

    @patient = Patient.new(
      user_id: @user.id,
      first_name: "Juan",
      last_name: "Perez"
    )
  end

  test "valid patient" do
    assert @patient.valid?
  end

  test "invalid without user" do
    @patient.user = nil
    assert_not @patient.valid?
  end

  test "invalid without first_name" do
    @patient.first_name = nil
    assert_not @patient.valid?
  end

  test "invalid without last_name" do
    @patient.last_name = nil
    assert_not @patient.valid?
  end

  test "belongs to user" do
    @patient.save!
    assert_equal @user, @patient.user
  end

  test "soft_delete sets deleted_at" do
    @patient.save!

    assert_nil @patient.deleted_at

    @patient.soft_delete
    @patient.reload

    assert_not_nil @patient.deleted_at
    assert @patient.deleted?
  end

  test "restore clears deleted_at" do
    @patient.save!
    @patient.soft_delete

    @patient.restore
    @patient.reload

    assert_nil @patient.deleted_at
    assert_not @patient.deleted?
  end

  test "soft_delete is idempotent" do
    @patient.save!

    @patient.soft_delete
    first_deleted_at = @patient.deleted_at

    @patient.soft_delete
    assert_equal first_deleted_at, @patient.deleted_at
  end

  test "restore is idempotent" do
    @patient.save!

    @patient.restore
    assert_nil @patient.deleted_at
  end

  test "full_name returns formatted name" do
    assert_equal "Juan Perez", @patient.full_name
  end
end
