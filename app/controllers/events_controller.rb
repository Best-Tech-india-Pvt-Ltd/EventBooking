class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_event, only: [:update, :destroy, :show]

  def index
    @events = Event.all
    render json: { message: 'List Of Events', event: @events }, status: :ok
  end

  def show
    organizer = User.find(@event.organizer_id)
    tickets  = @event.tickets
    render json: { message: 'Event Detail', event: @event, organizer_detail: organizer, ticket: tickets }, status: :ok
  end


  def create
    return render json: { error: 'Authorization token is missing' }, status: :unauthorized unless current_user.present?
    @event = current_user.events.new(event_params)
    authorize @event

    if @event.save
      render json: { message: 'Event created successfully', event: @event, tickets: @event.tickets }, status: :created
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    return render json: { error: 'Authorization token is missing' }, status: :unauthorized unless current_user.present?
    authorize @event

    if @event.update(event_params)
      render json: { message: 'Event updated successfully', event: @event, tickets: @event.tickets }
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    return render json: { error: 'Authorization token is missing' }, status: :unauthorized unless current_user.present?    
    authorize @event
    @event.tickets.each do |ticket|
      ticket.bookings.destroy_all
    end
    @event.destroy

    render json: { message: 'Event deleted successfully' }
  end

  private

  def set_event
    # @event = Event.find(params[:id])
    @event = Event.find_by(id: params[:id])
    render json: { error: 'Event not found' }, status: :not_found unless @event
  end

  def event_params
    params.require(:event).permit(:event_name, :event_date, :event_venue, tickets_attributes: [:name, :price, :availability])
  end
end
