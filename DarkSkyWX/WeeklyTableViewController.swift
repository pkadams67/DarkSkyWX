import UIKit

class WeeklyTableViewController: UITableViewController {

	// MARK: Internal

	var count = 0

	var images = ["background0",
	              "background1",
	              "background2",
	              "background3",
	              "background4",
				  "background5",
				  "background6",
				  "background7",
				  "background8",
	              "background9"]

	@IBOutlet var currentTemperatureLabel: UILabel?
	@IBOutlet var currentWeatherIcon: UIImageView?
	@IBOutlet var currentPrecipitationLabel: UILabel?
	@IBOutlet var currentTemperatureRangeLabel: UILabel?

	let coordinate: (lat: Double, lon: Double) = (35.965_880, -86.872_740)

	var weeklyWeather: [DailyWeather] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		addBackgroundImage()
		retrieveWeatherForecast()
		images = images.shuffle
	}

	func configureView() {
		tableView.separatorStyle = .singleLine
		tableView.separatorColor = .white.withAlphaComponent(0.5)
		tableView.backgroundView = WeeklyBackgroundView()
		tableView.rowHeight = 64
		if let navBarFont = UIFont(name: "Futura-Medium", size: 20) {
			let navBarAttributesDictionary: [NSAttributedString.Key: Any]? = [
				NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
				NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): navBarFont]
			navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
		}
		refreshControl?.layer.zPosition = (tableView.backgroundView!.layer.zPosition) + 1
		refreshControl?.tintColor = UIColor.white
	}

	func addBackgroundImage() {
		let background = tableView.backgroundView

		let image = UIImageView(image: UIImage(named: "background9"))
		image.contentMode = .scaleAspectFill

		let visualEffect = UIVisualEffectView()
		visualEffect.effect = UIBlurEffect(style: .dark)
		visualEffect.contentMode = .scaleAspectFill
		visualEffect.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height)
		visualEffect.alpha = 0.2

		image.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height)
		visualEffect.contentView.addSubview(image)
		background?.addSubview(visualEffect)
	}

	@IBAction func refreshWeather() {
		retrieveWeatherForecast()
		refreshControl?.endRefreshing()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDaily" {
			let dailyViewController = segue.destination as! DailyViewController
			let imageString = getImage()
			dailyViewController.imageString = imageString
			if let indexPath = tableView.indexPathForSelectedRow {
				let dailyWeather = weeklyWeather[indexPath.row]
				(segue.destination as! DailyViewController).dailyWeather = dailyWeather
			}
		}
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 50
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Forecast"
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return weeklyWeather.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! DailyWeatherTableViewCell
		let dailyWeather = weeklyWeather[indexPath.row]
		if let maxTemp = dailyWeather.maxTemperature {
			cell.temperatureLabel.text = "\(maxTemp)º"
		}
		cell.weatherIcon.image = dailyWeather.icon
		cell.dayLabel.text = dailyWeather.day
		return cell
	}

	override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		view.tintColor = .cyan.withAlphaComponent(2 / 3)
		if let header = view as? UITableViewHeaderFooterView {
			header.textLabel?.font = UIFont(name: "Futura-Medium", size: 18)
			header.textLabel?.textColor = UIColor.white
		}
	}

	override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath)
		cell?.contentView.backgroundColor = UIColor.cyan.withAlphaComponent(0.175)
		let highlightView = UIView()
		highlightView.backgroundColor = UIColor.cyan.withAlphaComponent(0.25)
		cell?.selectedBackgroundView = highlightView
	}

	func retrieveWeatherForecast() {
		let forecastService = ForecastService(APIKey: forecastAPIKey)
		forecastService.getForecast(coordinate.lat, lon: coordinate.lon) { forecast in

			if let weatherForecast = forecast,
			   let currentWeather = weatherForecast.currentWeather {

				DispatchQueue.main.async {

					if let temperature = currentWeather.temperature {
						self.currentTemperatureLabel?.text = "\(temperature)º"
					}

					if let precipitation = currentWeather.precipProbability {
						self.currentPrecipitationLabel?.text = "Rain: \(precipitation)%"
					}

					if let icon = currentWeather.icon {
						self.currentWeatherIcon?.image = icon
					}

					self.weeklyWeather = weatherForecast.weekly

					if let highTemp = self.weeklyWeather.first?.maxTemperature,
					   let lowTemp = self.weeklyWeather.first?.minTemperature {
						self.currentTemperatureRangeLabel?.text = "↓\(lowTemp)ºF  ↑\(highTemp)ºF"
					}

					self.tableView.reloadData()
				}
			}
		}
	}

	func getImage() -> String {
		let imageString = images[count]

		if count == images.count - 1 {
			count = 0
		} else {
			count += 1
		}
		return imageString
	}

	// MARK: Fileprivate

	fileprivate let forecastAPIKey = "720bb9b35db3004c7bfee81380e53d32"
}
