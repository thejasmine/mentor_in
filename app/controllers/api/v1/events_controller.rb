class Api::V1::EventsController < Api::V1::BaseController
skip_before_action :verify_authenticity_token
  def index
    @events = Event.all
    render json: @events, include: 'user'
  end
end
