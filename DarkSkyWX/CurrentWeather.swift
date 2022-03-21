import UIKit

struct CurrentWeather {

	// MARK: Lifecycle

	init(weatherDictionary: [String: AnyObject]) {
		if let currentTemp = weatherDictionary["temperature"] as? NSNumber {
			temperature = currentTemp.intValue
		} else {
			temperature = nil
		}

		if let humidityFloat = weatherDictionary["humidity"] as? Double {
			humidity = Int(humidityFloat * 100)
		} else {
			humidity = nil
		}

		if let precipFloat = weatherDictionary["precipProbability"] as? Double {
			precipProbability = Int(precipFloat * 100)
		} else {
			precipProbability = nil
		}

		summary = weatherDictionary["summary"] as? String

		if let iconString = weatherDictionary["icon"] as? String,
		   let weatherIcon = Icon(rawValue: iconString) {
			(icon, _) = weatherIcon.toImage()
		}
	}

	// MARK: Internal

	let temperature: Int?
	let humidity: Int?
	let precipProbability: Int?
	let summary: String?
	var icon: UIImage? = UIImage(named: "default.png")
}
