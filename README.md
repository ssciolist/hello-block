# Hello Block

Hello Block is a Ruby on Rails application designed to serve [real-world data](https://www.denvergov.org/content/denvergov/en/denver-development-services/help-me-find-/building-permits.html) about the changing landscape of Denver, as illustrated by its new construction. Using this application, you can search an address in the Denver metro area and return the estimated dollar amount of new construction in your area. If you're interested in tracking the result, users can sign up to recieve weekly emails about new construction in their area. 

See it for yourself at [hello-block.herokuapp.com](https://hello-block.herokuapp.com/)

## Setup

This application processes Denver Building Permit data using a separate repository, [denver-building-permit-scraper](https://github.com/ssciolist/denver-building-permit-scraper). 

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
