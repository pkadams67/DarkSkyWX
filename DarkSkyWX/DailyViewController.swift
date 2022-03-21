import UIKit

class DailyViewController: UIViewController {

	var imageString = ""

	@IBOutlet var weatherIcon: UIImageView?
	@IBOutlet var summaryLabel: UILabel?
	@IBOutlet var sunriseTimeLabel: UILabel?
	@IBOutlet var sunsetTimeLabel: UILabel?
	@IBOutlet var lowTemperatureLabel: UILabel?
	@IBOutlet var highTemperatureLabel: UILabel?
	@IBOutlet var precipitationLabel: UILabel?
	@IBOutlet var humidityLabel: UILabel?
	@IBOutlet var backgroundImage: UIImageView!

	var dailyWeather: DailyWeather? {
		didSet {
			configureView()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		backgroundImage.image = UIImage(named: imageString)
		configureView()
	}

	func configureView() {
		if let weather = dailyWeather {
			title = weather.day
			weatherIcon?.image = weather.icon
			summaryLabel?.text = weather.summary
			sunriseTimeLabel?.text = weather.sunriseTime
			sunsetTimeLabel?.text = weather.sunsetTime

			if let lowTemp = weather.minTemperature,
			   let highTemp = weather.maxTemperature,
			   let rain = weather.precipChance,
			   let humidity = weather.humidity {
				lowTemperatureLabel?.text = "\(lowTemp)ºF"
				highTemperatureLabel?.text = "\(highTemp)ºF"
				precipitationLabel?.text = "\(rain)%"
				humidityLabel?.text = "\(humidity)%"
			}
		}

		if let buttonFont = UIFont(name: "Futura-Medium", size: 20) {
			let barButtonAttributesDictionary: [NSAttributedString.Key: Any]? = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
			                                                                     NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): buttonFont]
			UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttributesDictionary, for: UIControl.State())
		}
	}
}
