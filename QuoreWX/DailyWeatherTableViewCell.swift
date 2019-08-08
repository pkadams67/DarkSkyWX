//
//  DailyWeatherTableViewCell.swift
//  QuoreWX
//
//  Created by Paul Adams on 8/8/19.
//  Copyright © 2019 Paul Adams. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
