class SessionNotesController < ApplicationController
  def new
    @session_note = SessionNote.new
  end

  def create
    @session_note = SessionNote.new(session_note_params)
    @session_note.save
    redirect_to @session_note
  end

  private

  def session_note_params
    params.require(:session_note).permit(:content, :patient_id)
  end
end