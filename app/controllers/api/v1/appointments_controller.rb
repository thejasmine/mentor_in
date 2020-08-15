class Api::V1::AppointmentsController < ApplicationController
  before_action :find_appointment, only: [:update, :destroy]
  skip_before_action :verify_authenticity_token
  # def index
  #   user = User.find(params[:user_id])
  #   @appointments = Appointment.where(requester_id: user)
  #   @owner_appointments = user.appointments_as_owner
  #   render json: @appointments, include: 'reviews'
  # end

  def user_appointment
    user = User.find(params[:user_id])
    @appointments = Appointment.where(requester_id: user)
    @owner_appointments = user.appointments_as_owner
    render json: @appointments, include: 'reviews'
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @event = Event.find(params[:event_id])
    user = User.find(params[:user_id])
    # @user = current_user
    @appointment.requester_id = user
    @appointment.event_id = @event.id
    if @appointment.save
      render json: @appointments
    else
      render :new
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    @appointment.update(appointment_finished_params)
    render json: @appointments
  end

  def destroy
    @appointment.destroy
    render json: @appointments
  end

  private
  def find_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:date, :user_id)
  end

  def appointment_finished_params
    params.permit(:status)
  end
end

