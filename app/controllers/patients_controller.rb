class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show edit update destroy summary]

  def index
    @q = current_user.patients.active.ransack(params[:q])
    @patients = @q.result.ordered
  end

  def show
    @initial_interview = @patient.notes.active.find_by(note_type: "initial_interview")
    @recent_notes = @patient.notes.active.where.not(id: @initial_interview&.id).ordered.limit(5)
    @total_notes = @patient.notes.active.count
  end

  def new
    @patient = current_user.patients.new
  end

  def create
    @patient = current_user.patients.new(patient_params)

    if @patient.save
      redirect_to @patient, notice: "Paciente creado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: "Paciente actualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @patient.soft_delete
    redirect_to patients_path, notice: "Paciente archivado."
  end

  def summary
    @recent_notes = @patient.notes.active.ordered.limit(5)
  end

  private

  def set_patient
    @patient = current_user.patients.active.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:first_name, :last_name)
  end
end
