# OpenStreetMap

Integration of OpenStreetMap api from [Nominatim](https://wiki.openstreetmap.org/wiki/Nominatim)

## Prerequisites

This project requires:

* Ruby >= 2.3.1, but can work with earlier versions
* HTTParty >= 0.16

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'open_street_map'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install open_street_map

## Usage

### Create OpenStreetMap client object

```ruby
  client = OpenStreetMap::Client.new
```

### Search

Request for search objects is #search.

```ruby
  client.search(q: '135 pilkington avenue, birmingham', format: 'json', addressdetails: '1', accept_language: 'ru')
```
    q - query
    format - one of the [xml|json|jsonv2], default - xml
    viewbox - The preferred area to find search results like <x1>,<y1>,<x2>,<y2>
    bounded - Restrict the results to only items contained with the viewbox, one of the [0|1]
    addressdetails - Include a breakdown of the address into elements, one of the [0|1]
    exclude_place_ids - If you do not want certain openstreetmap objects to appear in the search result, give a comma separated list of the place_id's you want to skip
    limit - Limit the number of returned results, integer
    extratags - Include additional information in the result if available, one of the [0|1]
    namedetails - Include a list of alternative names in the results, one of the [0|1]
    accept_language - Preferred language order for showing search results, default - en
    email - If you are making large numbers of request please include a valid email address
    user_agent - User-Agent identifying the application, default - webgents/open_street_map_gem_random
    hostname - allow overwriting the host name for users who have their own Nominatim installation, default - https://nominatim.openstreetmap.org/

#### Responses

```ruby
  [
    {
      "place_id":"91015286",
      "licence":"Data © OpenStreetMap contributors, ODbL 1.0. https:\/\/osm.org\/copyright",
      "osm_type":"way",
      "osm_id":"90394480",
      "boundingbox":["52.5487473","52.5488481","-1.816513","-1.8163464"],
      "lat":"52.5487921",
      "lon":"-1.8164308339635",
      "display_name":"135, Pilkington Avenue, Sutton Coldfield, Бирмингем, West Midlands Combined Authority, Западный Мидленд, Англия, B72 1LH, Великобритания",
      "class":"building",
      "type":"yes",
      "importance":0.31025,
      "address": {
        "house_number":"135",
        "road":"Pilkington Avenue",
        "town":"Sutton Coldfield",
        "city":"Бирмингем",
        "county":"West Midlands Combined Authority",
        "state_district":"Западный Мидленд",
        "state":"Англия",
        "postcode":"B72 1LH",
        "country":"Великобритания",
        "country_code":"gb"
      }
    }
  ]
```

### Reverse

Request for objects by coordinates is #reverse.

```ruby
  client.reverse(format: 'json', lat: '52.594417', lon: '39.493115', accept_language: 'ru')
```
    format - one of the [xml|json|jsonv2], default - xml
    zoom - Level of detail required where 0 is country and 18 is house/building, one of the [0-18]
    addressdetails - Include a breakdown of the address into elements, one of the [0|1]
    lat - Latitude, required
    lon - Longitude, required
    extratags - Include additional information in the result if available, one of the [0|1]
    namedetails - Include a list of alternative names in the results, one of the [0|1]
    accept_language - Preferred language order for showing search results, default - en
    email - If you are making large numbers of request please include a valid email address
    user_agent - User-Agent identifying the application, default - webgents/open_street_map_gem_random
    hostname - allow overwriting the host name for users who have their own Nominatim installation, default - https://nominatim.openstreetmap.org/

#### Responses

```ruby
  {
    "place_id":"150727169",
    "licence":"Data © OpenStreetMap contributors, ODbL 1.0. https:\/\/osm.org\/copyright",
    "osm_type":"way",
    "osm_id":"367091730",
    "lat":"52.5944624",
    "lon":"39.4931348495468",
    "display_name":"4, улица Хренникова, микрорайон Елецкий, Сырский рудник, Советский округ, Липецк, городской округ Липецк, Липецкая область, Центральный федеральный округ, 398000, РФ",
    "address":{
      "house_number":"4",
      "road":"улица Хренникова",
      "residential":"микрорайон Елецкий",
      "suburb":"городской округ Липецк",
      "city_district":"Советский округ",
      "city":"Липецк",
      "state":"Липецкая область",
      "postcode":"398000",
      "country":"РФ",
      "country_code":"ru"
    },
    "boundingbox":["52.5943024","52.5946223","39.4929211","39.4933486"]
  }
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/WebGents/open_street_map.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Disclaimer

Use this package at your own peril and risk, the author tried to simplify the use of [Nominatim service](https://wiki.openstreetmap.org/wiki/Nominatim) for integration into Ruby on Rails web applications.
