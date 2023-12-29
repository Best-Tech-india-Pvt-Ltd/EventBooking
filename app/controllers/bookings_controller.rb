class BookingsController < ApplicationController
    before_action :set_booking, only: [:destroy, :show]
    skip_before_action :verify_authenticity_token

  def index
    @booking = Booking.all
    render json: { message: 'Booking List', booking: @booking }, status: :ok
  end

  def customer_booking
    return render json: { error: 'Authorization token is missing' }, status: :unauthorized unless current_user.present? 
    @booking = current_user.bookings
    render json: { message: 'Booking List', booking: @booking }, status: :ok
  end

  def show
    @event = Event.find(@booking.event_id)
    @ticket = Ticket.find(@booking.ticket_id)
    @organizer = User.find(@event.organizer_id)
    @organizer = User.find(@booking.customer_id)
    render json: { message: 'Booking Details', booking: @booking, customer: @customer, event: @event, ticket: @ticket, organizer: @organizer }, status: :ok
  end

  def create
    return render json: { error: 'Authorization token is missing' }, status: :unauthorized unless current_user.present? 
    @booking = current_user.bookings.new(booking_params)
    authorize @booking

    if @booking.save
      @booking.ticket.update(availability: @booking.ticket.availability - @booking.quantity)
      
      render json: { message: 'Booking created successfully', booking: @booking }, status: :created
    else
      render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    return render json: { error: 'Authorization token is missing' }, status: :unauthorized unless current_user.present? 
    authorize @booking
    @booking.ticket.update(availability: @booking.ticket.availability + @booking.quantity)
    @booking.destroy
    render json: { message: 'Booking deleted successfully' }
  end


  private

  def set_booking
    # @booking = Booking.find(params[:id])
    @booking = Booking.find_by(id: params[:id])
    render json: { error: 'Booking not found' }, status: :not_found unless @booking
  end

  def booking_params
    params.require(:booking).permit(:event_id, :ticket_id, :quantity)
  end
end
