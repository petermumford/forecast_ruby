module ForecastRuby
	module Helpers
		def encode(object)
      ::MultiJson.encode(object)
    end

    def decode(object)
      return unless object

      begin
        ::MultiJson.decode(object)
      rescue ::MultiJson::DecodeError => e
        raise DecodeException, e
      end
    end

    # ForecastRuby.get_wind_direction( your windBearing value )
		def get_wind_direction(degree)
			windDir = ["N", "NNE", "NE", "ENE",
								"E", "ESE", "SE", "SSE",
								"S", "SSW", "SW", "WSW",
								"W", "WNW", "NW", "NNW"]
			d = ((degree.to_i + 11) / 22.5) % 16
			windDir[ d.floor ]
		end

		def get_weather_icon(option)
			# uses climacons
			# could be one of the following. End with a default icon incase the API adds new values
			# clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night
			result = "climacon "
			case option
				when 'clear-day'
					result << "sun"
				when 'clear-night'
					result << "moon"
				when 'rain'
					result << "rain"
				when 'snow'
					result << "snow"
				when 'sleet'
					result << "sleet"
				when 'wind'
					result << "wind"
				when 'fog'
					result << "fog"
				when 'cloudy'
					result << "cloud"
				when 'partly-cloudy-day'
					result << "cloud sun"
				when 'partly-cloudy-night'
					result << "cloud moon"
				else
					result << "moon new"
			end
		end


	end
end