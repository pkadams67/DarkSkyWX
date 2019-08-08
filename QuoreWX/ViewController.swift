//
//  ViewController.swift
//  QuoreWX
//
//  Created by Paul Adams on 8/8/19.
//  Copyright © 2019 Paul Adams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dailyWeather: DailyWeather? {
        didSet {
            configureView()
        }
    }
    
    var imageString = ""
    
    @IBOutlet weak var weatherIcon: UIImageView?
    @IBOutlet weak var summaryLabel: UILabel?
    @IBOutlet weak var sunriseTimeLabel: UILabel?
    @IBOutlet weak var sunsetTimeLabel: UILabel?
    @IBOutlet weak var lowTemperatureLabel: UILabel?
    @IBOutlet weak var highTemperatureLabel: UILabel?
    @IBOutlet weak var precipitationLabel: UILabel?
    @IBOutlet weak var humidityLabel: UILabel?
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        backgroundImage.image = UIImage.init(named: imageString)
        
        configureView()
        
    }
    
    func configureView() {
        if let weather = dailyWeather {
            self.title = weather.day
            weatherIcon?.image = weather.icon
            summaryLabel?.text = weather.summary
            sunriseTimeLabel?.text = weather.sunriseTime
            sunsetTimeLabel?.text = weather.sunsetTime
            
            if let lowTemp = weather.minTemperature,
                let highTemp = weather.maxTemperature,
                let rain = weather.precipChance,
                let humidity = weather.humidity {
                lowTemperatureLabel?.text = "\(lowTemp)º"
                highTemperatureLabel?.text = "\(highTemp)º"
                precipitationLabel?.text = "\(rain)%"
                humidityLabel?.text = "\(humidity)%"
            }
            
            
        }
        
        if let buttonFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
            let barButtonAttributesDictionary: [NSAttributedString.Key: Any]? = [
                NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
                NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): buttonFont
            ]
            UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttributesDictionary, for: UIControl.State())
        }
        
    }
    
}
