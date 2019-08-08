//
//  WeeklyTableViewController.swift
//  QuoreWX
//
//  Created by Paul Adams on 8/8/19.
//  Copyright © 2019 Paul Adams. All rights reserved.
//

import UIKit

class WeeklyTableViewController: UITableViewController {
    
    var count = 0
    
    var images = [
        "Chicos",
        "CoolSprings",
        "CountryRoad",
        "Grays",
        "Presbyterian",
        "Square"
    ]
    
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentPrecipitationLabel: UILabel?
    @IBOutlet weak var currentTemperatureRangeLabel: UILabel?
    
    let coordinate: (lat: Double, lon: Double) = (35.951371,-86.808793)
    
    fileprivate let forecastAPIKey = "720bb9b35db3004c7bfee81380e53d32"
    
    var weeklyWeather: [DailyWeather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addBackgroundImage()
        
        retrieveWeatherForecast()
        
        images = images.shuffle
    }
    
    
    func configureView() {
        tableView.backgroundView = BackgroundView()
        tableView.rowHeight = 64
        if let navBarFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
            let navBarAttributesDictionary: [NSAttributedString.Key: Any]? = [
                NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
                NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): navBarFont
            ]
            navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
        }
        refreshControl?.layer.zPosition = tableView.backgroundView!.layer.zPosition + 1
        refreshControl?.tintColor = UIColor.white
    }
    
    func addBackgroundImage() {
        let background = tableView.backgroundView
        
        let image = UIImageView.init(image: UIImage.init(named: "Theater"))
        image.contentMode = .scaleAspectFill
        
        let visualEffect = UIVisualEffectView()
        visualEffect.effect = UIBlurEffect(style: .dark)
        visualEffect.contentMode = .scaleAspectFill
        visualEffect.frame = CGRect.init(x: 0, y: 64, width: tableView.frame.width, height: tableView.frame.height - 64)
        
        visualEffect.alpha = 0.2
        
        image.frame = CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height - 64)
        visualEffect.contentView.addSubview(image)
        background?.addSubview(visualEffect)
    }
    
    @IBAction func refreshWeather() {
        retrieveWeatherForecast()
        refreshControl?.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDaily" {
            let vc = segue.destination as! ViewController
            let imageString = getImage()
            vc.imageString = imageString
            if let indexPath = tableView.indexPathForSelectedRow {
                let dailyWeather = weeklyWeather[indexPath.row]
                (segue.destination as! ViewController).dailyWeather = dailyWeather
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Forecast"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
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
    
    // MARK: - Table View Delegate Methods
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red:0.20, green:0.34, blue:0.08, alpha:1.0)
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 14.0)
            header.textLabel!.textColor = UIColor.white
        }
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = UIColor(red:0.20, green:0.34, blue:0.08, alpha:1.0)
        let highlightView = UIView()
        highlightView.backgroundColor = UIColor(red:0.20, green:0.34, blue:0.08, alpha:1.0)
        cell?.selectedBackgroundView = highlightView
    }
    
    
    // MARK: - Weather Fetching
    
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, lon: coordinate.lon) {
            (forecast) in
            
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
                        self.currentTemperatureRangeLabel?.text = "↑\(highTemp)º↓\(lowTemp)º"
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
}
