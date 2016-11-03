# Parking Pal

## Authors

* Vikas Bhetanabhotla
* Matthew Turk
* Allen Wang 

## Purpose

Parking can be a pain. It takes forever to find locations and even then, it's hard to determine if it costs money or not. With this applications, users report their findings to each other to create a global scalable application that easily allows the user to find optimal parking spots at the tips of his/her fingers.

## Features

The user will be given two abilities: `Notify` and `Observe`. `Notify` will allow users to report either a congested parking lot or an open spot. Other data will be included as well-- for instance, any costs, type of parking spots, as well as safety around the area. Our application will have a secondary view for every parking area that displays patterns crowdedness by time. Every user will get tokens for every report that they submit so that they can `Observe`. `Observe` will allow the user to see all of these reports in real time.

## Control Flow

Users are brought to a home screen where two buttons exist as mentioned above. `Notify` will go to a new text submission screen that has selection buttons of empty, moderate, and full. There will also be optional text options describing prices and safety around the area. This will then be sent to our backend in a format of {TTL: Int, GPS-X-Coordinate: Float, GPS-Y-Coordinate: Float, Crowdedness: Int, Price: Int, Reports: String}. This will be then stored into a HashMap of regions (which contain 5 square miles of area).

## Implementation

### Overview

A crowd sourced application that allows users to report the availability of parking locations. These reports are compiled into a feed which will be shown on an interactive display that implements [Google Maps API](https://developers.google.com/maps/documentation/ios-sdk/). This data will be stored using [Firebase](https://firebase.google.com/docs/ios/setup). 

### Model

* Region
 ** Each region will contain a list of reports

* Report
 ** Time to live: an integer of how long this report will be stored
 ** GPS-Coordinate: a tuple location of where this report was filed
 ** Crowdedness: an integer {0..3} representing the crowdedness
 ** Price: an integer of the cost of the parking spot
 ** Other: A string of any additional info

### View

* Map View
  ** Implements the Google Map API and shows highlighted regions (varying of color) of how crowded a parking spot is. On a click, this shows a popup of statsitics of the area

* Report View
  ** A simple text based forum that allows users to file a `Report`

### Controller

* Report Submit
  ** On click, saves the new Report and preforms a post request to our database. Region will then be updated locally. The application will periodically fetch from the database by checking a hash of the region to see if any new reports were brought up.

* On Map Click
  ** On click, modifies the map view to display statistics of the area.

### Other Libraries

* Google Maps API
* Firebase


