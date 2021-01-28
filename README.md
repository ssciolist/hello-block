# Hello Block

Hello Block was a Ruby on Rails application designed to serve real-world data about the changing landscape of Denver, as illustrated by its new construction. However, in the years since its inception, the city of Denver changed the way the permit data was stored, which made impossible for me to continue scraping the data. A perfect example of Denver's changing landscape, you could say. Using this application, one was able to search an address in the Denver metro area and return the estimated dollar amount of new construction in your area. If you were interested in tracking the result, users were able sign up to recieve weekly emails about new construction in their area.


## Setup

Once you've forked or cloned this repository to your computer, run bundle install to get the proper ruby dependencies installed. Then run `yarn install` to get the javascript packages (chart.js and mapbox) installed.

Then, create your database:

rails db:create

rails db:migrate

Next, seed your database with the Denver neighborhoods:

rake db:seed

Now you should be able to run rails s to start a server. Most server instances will be accessible at http://localhost:3000/.

To see the site locally, you'll also want to run `MAPBOX_KEY=YOUR_KEY_HERE bin/webpack-dev-server`

## Built with
* [Geocoder](https://github.com/alexreisner/geocoder)
* [Google Maps API](https://cloud.google.com/maps-platform/)
* [Google Places API](https://developers.google.com/places/web-service/intro)
* [SendGrid](https://sendgrid.com/docs/Integrate/Frameworks/rubyonrails.html)

## Running the tests

Use `rspec` from the terminal to run all tests.

## Versions

* Ruby version 2.4.1
* Rails version 5.6.1
* Rspec version 3.7.1
