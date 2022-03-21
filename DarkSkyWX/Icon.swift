import UIKit

enum Icon: String {
	case clearDay = "clear-day"
	case clearNight = "clear-night"
	case rain = "rain"
	case snow = "snow"
	case sleet = "sleet"
	case wind = "wind"
	case fog = "fog"
	case cloudy = "cloudy"
	case partlyCloudyDay = "partly-cloudy-day"
	case partlyCloudyNight = "partly-cloudy-night"

	func toImage() -> (regularIcon: UIImage?, largeIcon: UIImage?) {
		var imageName: String

		switch self {
			case .clearDay:
				imageName = "clear-day"
			case .clearNight:
				imageName = "clear-night"
			case .rain:
				imageName = "rain"
			case .snow:
				imageName = "snow"
			case .sleet:
				imageName = "sleet"
			case .wind:
				imageName = "wind"
			case .fog:
				imageName = "fog"
			case .cloudy:
				imageName = "cloudy"
			case .partlyCloudyDay:
				imageName = "cloudy-day"
			case .partlyCloudyNight:
				imageName = "cloudy-night"
		}

		let regularIcon = UIImage(named: "\(imageName).png")
		let largeIcon   = UIImage(named: "\(imageName)_large.png")

		return (regularIcon, largeIcon)
	}
}
