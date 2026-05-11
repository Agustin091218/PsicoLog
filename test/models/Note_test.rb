require "test_helper"

class NoteTest < ActiveSupport::TestCase
  setup do
    user = User.create!(
      first_name: "Test",
      last_name: "User",
      email: "note_test_#{SecureRandom.hex(6)}@example.com",
      password: "123456",
      password_confirmation: "123456"
    )

    @patient = Patient.create!(
      user: user,
      first_name: "Juan",
      last_name: "Perez"
    )
  end

  test "valid note" do
    note = build_note
    assert note.valid?
  end

  test "invalid without patient" do
    note = build_note(patient: nil)
    assert_not note.valid?
  end

  test "invalid without note_type" do
    note = build_note(note_type: nil)
    assert_not note.valid?
  end

  test "invalid with unsupported note_type" do
    note = build_note(note_type: "invalid_type")
    assert_not note.valid?
  end

  test "invalid without recorded_at" do
    note = build_note(recorded_at: nil)
    assert_not note.valid?
  end

  test "invalid without content" do
    note = build_note(content: nil)
    assert_not note.valid?
  end

  test "active scope only returns non-deleted notes" do
    active_note = build_note(content: "active")
    deleted_note = build_note(content: "deleted", deleted_at: Time.current)
    active_note.save!
    deleted_note.save!

    assert_includes Note.active, active_note
    assert_not_includes Note.active, deleted_note
  end

  test "ordered scope returns newest first" do
    old_note = build_note(recorded_at: 1.day.ago, content: "old")
    new_note = build_note(recorded_at: Time.current, content: "new")
    old_note.save!
    new_note.save!

    assert_equal new_note, Note.ordered.first
    assert_equal old_note, Note.ordered.last
  end

  test "soft_delete sets deleted_at" do
    note = build_note
    note.save!

    assert_nil note.deleted_at
    note.soft_delete
    note.reload
    assert_not_nil note.deleted_at
  end

  test "restore clears deleted_at" do
    note = build_note
    note.save!
    note.soft_delete

    note.restore
    note.reload
    assert_nil note.deleted_at
  end

  test "deleted? returns false when deleted_at is nil" do
    note = build_note
    note.save!

    assert_not note.deleted?
  end

  test "deleted? returns true when deleted_at is present" do
    note = build_note
    note.save!
    note.soft_delete
    note.reload

    assert note.deleted?
  end

  test "note_types exposes the expected constants" do
    assert_equal %w[session_note initial_interview follow_up emergency discharge general_note quick_note], Note.note_types
  end

  private

  def build_note(attributes = {})
    defaults = {
      patient: @patient,
      note_type: "quick_note",
      recorded_at: Time.current,
      content: "test content"
    }

    Note.new(defaults.merge(attributes))
  end
end
