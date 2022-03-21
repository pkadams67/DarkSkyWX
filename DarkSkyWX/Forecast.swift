import Foundation

struct Forecast {

	// MARK: Lifecycle

	init(weatherDictionary: [String: AnyObject]?) {
		if let currentWeatherDictionary = weatherDictionary?["currently"] as? [String: AnyObject] {
			currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
		}
		if let weeklyWeatherArray = weatherDictionary?["daily"]?["data"] as? [[String: AnyObject]] {
			for dailyWeather in weeklyWeatherArray {
				let daily = DailyWeather(dailyWeatherDict: dailyWeather)
				weekly.append(daily)
			}
		}
	}

	// MARK: Internal

	var currentWeather: CurrentWeather?
	var weekly: [DailyWeather] = []
}
