class Api::V1::EventsController < Api::V1::BaseController
skip_before_action :verify_authenticity_token
before_action :find_event, only: [ :show, :update, :destroy]

  def index
    @events = Event.all
    render json: @events, include: 'user'
  end

  def show
    render json: @event, include: ['user','appointments']
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @event.update(event_params)
      render :show
    else
      render_error
    end
  end

  def destroy
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description,:category,:level,:link,:start_time, :end_time,:capacity)
  end

  def render_error
    render json: { errors: @event.errors.full_messages },
      status: :unprocessable_entity
  end
end
