import Foundation

struct ForecastService {

	// MARK: Lifecycle

	init(APIKey: String) {
		forecastAPIKey = "720bb9b35db3004c7bfee81380e53d32"
		forecastBaseURL = URL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
	}

	// MARK: Internal

	let forecastAPIKey: String
	let forecastBaseURL: URL?

	func getForecast(_ lat: Double, lon: Double, completion: @escaping ((Forecast?) -> Void)) {
		if let forecastURL = URL(string: "\(lat),\(lon)", relativeTo: forecastBaseURL) {
			let networkOperation = NetworkOperation(url: forecastURL)
			networkOperation.downloadJSONFromURL { JSONDictionary in
				let forecast = Forecast(weatherDictionary: JSONDictionary)
				completion(forecast)
			}
		} else {
			print("Could not construct a valid URL")
		}
	}
}
