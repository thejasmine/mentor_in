class Api::V1::EventsController < Api::V1::BaseController
skip_before_action :verify_authenticity_token
  def index
    @events = Event.all
    render json: @events, include: 'user'
  end

  def show
    @event = Event.find(params[:id])
    render json: @event, include: ['user','appointments']
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      render :show
    else
      render_error
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
  end


  private

  def event_params
     params.require(:event).permit(:name, :description,:category,:level,:link,:start_time, :end_time,:capacity, :user_id)
  end

  def render_error
    render json: {error: @event.errors.full_messaages}
  end
end
