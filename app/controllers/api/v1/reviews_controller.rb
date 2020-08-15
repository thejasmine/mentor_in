class Api::V1::ReviewsController < ApplicationController
skip_before_action :verify_authenticity_token
  def new
    @review = Review.new
    @appointment = Appointment.find(params[:appointment_id])
  end

  def create
    @review = Review.new(review_params)
    @appointment = Appointment.find(params[:appointment_id])
    @review.appointment_id = @appointment.id
    if @review.save
      render json: @review
    else
      raise
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :content,:rating)
  end
end
