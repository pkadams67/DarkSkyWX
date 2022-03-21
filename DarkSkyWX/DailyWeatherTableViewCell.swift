import UIKit

class DailyWeatherTableViewCell: UITableViewCell {

	@IBOutlet var temperatureLabel: UILabel!
	@IBOutlet var weatherIcon: UIImageView!
	@IBOutlet var dayLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
}
