# EventBooking

This is a Ruby on Rails project for managing events, bookings, and tickets.

## Prerequisites

Make sure you have the following installed on your machine:

- [Ruby](https://www.ruby-lang.org/)
- [Ruby on Rails](https://rubyonrails.org/)


## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/Best-Tech-india-Pvt-Ltd/EventBooking.git

2. Navigate to directory:

   cd EventBooking

3. Install dependencies:

    bundle install

4. Set-up database:

    rails db:create
    rails db:migrate

5. Start rails server:

    rails s


## Features
1. Event Management: Create, read, update, and delete events by event_organizer.
2. Ticket Management: Define types of tickets for each event.
3. Booking: Allow customers to book tickets for events by customers.
4. User Authentication: Authenticate users as event organizers or customers.
5. Authorization: Implement access control based on user roles.