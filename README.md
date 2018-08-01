# Hello Block

Hello Block is a Ruby on Rails application designed to serve [real-world data](https://www.denvergov.org/content/denvergov/en/denver-development-services/help-me-find-/building-permits.html) about the changing landscape of Denver, as illustrated by its new construction. Using this application, you can search an address in the Denver metro area and return the estimated dollar amount of new construction in your area. If you're interested in tracking the result, users can sign up to recieve weekly emails about new construction in their area.

See it for yourself at [hello-block.herokuapp.com](https://hello-block.herokuapp.com/)

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
