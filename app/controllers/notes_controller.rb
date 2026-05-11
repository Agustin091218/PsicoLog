class NotesController < ApplicationController
  before_action :set_patient, except: :all
  before_action :set_note, only: %i[show edit update destroy]

  def index
    @q = @patient.notes.active.ransack(params[:q])
    @notes = @q.result.ordered
  end

  def all
    patient_ids = current_user.patients.active.pluck(:id)
    @q = Note.active.where(patient_id: patient_ids).ransack(params[:q])
    @notes = @q.result.ordered.includes(:patient)
  end

  def show
  end

  def new
    @note = @patient.notes.new(note_type: "session_note", recorded_at: Time.current)
  end

  def create
    @note = @patient.notes.new(note_params)

    if @note.save
      redirect_to patient_notes_path(@patient), notice: "Nota creada."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to patient_note_path(@patient, @note), notice: "Nota actualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @note.soft_delete
    redirect_to patient_notes_path(@patient), notice: "Nota archivada."
  end

  private

  def set_patient
    @patient = current_user.patients.active.find(params[:patient_id])
  end

  def set_note
    @note = @patient.notes.active.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:note_type, :content, :recorded_at)
  end
end
