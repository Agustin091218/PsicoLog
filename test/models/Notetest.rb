# spec/models/note_spec.rb
require "rails_helper"

RSpec.describe Note, type: :model do
  # --- Pruebas de Asociaciones ---
  describe "associations" do
    it { should belong_to(:patient) }
  end

  # --- Pruebas de Validaciones ---
  describe "validations" do
    it { should validate_presence_of(:patient_id) }
    it { should validate_presence_of(:note_type) }
    it { should validate_presence_of(:recorded_at) }
    it { should validate_presence_of(:content) }

    it do
      should validate_inclusion_of(:note_type)
        .in_array(%w[session_note general_note quick_note])
    end
  end

  # --- Pruebas de Scopes ---
  describe "scopes" do
    let!(:active_note) { Note.create!(patient_id: 1, note_type: "general_note", recorded_at: Time.current, content: "Active", deleted_at: nil) }
    let!(:deleted_note) { Note.create!(patient_id: 1, note_type: "general_note", recorded_at: Time.current, content: "Deleted", deleted_at: Time.current) }
    let!(:old_note) { Note.create!(patient_id: 1, note_type: "general_note", recorded_at: 1.day.ago, content: "Old") }
    let!(:new_note) { Note.create!(patient_id: 1, note_type: "general_note", recorded_at: Time.current, content: "New") }

    it ".active returns only notes where deleted_at is nil" do
      expect(Note.active).to include(active_note)
      expect(Note.active).not_to include(deleted_note)
    end

    it ".ordered returns notes sorted by recorded_at in descending order" do
      expect(Note.ordered.first).to eq(new_note)
      expect(Note.ordered.last).to eq(old_note)
    end
  end

  # --- Pruebas de Métodos de Instancia ---
  describe "instance methods" do
    let(:note) { Note.create!(patient_id: 1, note_type: "quick_note", recorded_at: Time.current, content: "Test content") }

    describe "#soft_delete" do
      it "sets deleted_at timestamp" do
        expect { note.soft_delete }.to change { note.deleted_at }.from(nil)
      end
    end

    describe "#restore" do
      it "sets deleted_at back to nil" do
        note.soft_delete
        expect { note.restore }.to change { note.deleted_at }.to(nil)
      end
    end

    describe "#active?" do
      it "returns true if deleted_at is nil" do
        expect(note.active?).to be true
      end

      it "returns false if deleted_at is present" do
        note.soft_delete
        expect(note.active?).to be false
      end
    end
  end

  # --- Pruebas de Métodos de Clase ---
  describe "class methods" do
    it ".note_types returns the correct constants" do
      expect(Note.note_types).to eq(%w[session_note general_note quick_note])
    end
  end
end
