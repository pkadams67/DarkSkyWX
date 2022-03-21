import Foundation
import UIKit

struct DailyWeather {

	// MARK: Lifecycle

	init(dailyWeatherDict: [String: Any]) {

		if let max = dailyWeatherDict["temperatureMax"] as? NSNumber {
			maxTemperature = max.intValue
		} else {
			maxTemperature = nil
		}

		if let min = dailyWeatherDict["temperatureMin"] as? NSNumber {
			minTemperature = min.intValue
		} else {
			minTemperature = nil
		}

		if let humidityFloat = dailyWeatherDict["humidity"] as? Double {
			humidity = Int(humidityFloat * 100)
		} else {
			humidity = nil
		}

		if let precipChanceFloat = dailyWeatherDict["precipProbability"] as? Double {
			precipChance = Int(precipChanceFloat * 100)
		} else {
			precipChance = nil
		}

		summary = dailyWeatherDict["summary"] as? String

		if let iconString = dailyWeatherDict["icon"] as? String,
		   let iconEnum = Icon(rawValue: iconString) {
			(icon, largeIcon) = iconEnum.toImage()
		}

		if let sunriseDate = dailyWeatherDict["sunriseTime"] as? Double {
			sunriseTime = timeStringFromUnixTime(sunriseDate)
		}

		if let sunsetDate = dailyWeatherDict["sunsetTime"] as? Double {
			sunsetTime = timeStringFromUnixTime(sunsetDate)
		}

		if let time = dailyWeatherDict["time"] as? Double {
			day = dayStringFromTime(time)
		}
	}

	// MARK: Internal

	let maxTemperature: Int?
	let minTemperature: Int?
	let humidity: Int?
	let precipChance: Int?
	let summary: String?
	var icon: UIImage? = UIImage(named: "default.png")
	var largeIcon: UIImage? = UIImage(named: "default_large.png")
	var sunriseTime: String?
	var sunsetTime: String?
	var day: String?
	let dateFormatter = DateFormatter()

	func timeStringFromUnixTime(_ unixTime: Double) -> String {
		let date = Date(timeIntervalSince1970: unixTime)
		dateFormatter.dateFormat = "HH:mm"
		return dateFormatter.string(from: date)
	}

	func dayStringFromTime(_ unixTime: Double) -> String {
		let date = Date(timeIntervalSince1970: unixTime)
		dateFormatter.locale = Locale(identifier: Locale.current.identifier)
		dateFormatter.dateFormat = "EEEE"
		return dateFormatter.string(from: date)
	}
}
