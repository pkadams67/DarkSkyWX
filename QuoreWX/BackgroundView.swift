//
//  ViewController.swift
//  QuoreWX
//
//  Created by Paul Adams on 8/8/19.
//  Copyright © 2019 Paul Adams. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        // Background View
        
        //// Color Declarations
        let quoreGreenLight: UIColor = UIColor(red:0.36, green:0.70, blue:0.02, alpha:1.0)
        let quoreGreenDark: UIColor  = UIColor(red:0.20, green:0.34, blue:0.08, alpha:1.0)
        
        let context = UIGraphicsGetCurrentContext()
        
        //// Gradient Declarations
        let quoreGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [quoreGreenLight.cgColor, quoreGreenDark.cgColor] as CFArray, locations: [0, 1])
        
        //// Background Drawing
        let backgroundPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        let options: CGGradientDrawingOptions = [.drawsBeforeStartLocation, .drawsAfterEndLocation]
        context?.saveGState()
        backgroundPath.addClip()
        context?.drawLinearGradient(quoreGradient!,
                                    start: CGPoint(x: 160, y: 0),
                                    end: CGPoint(x: 160, y: 568),
                                    options: options.self)
        context?.restoreGState()
    }
}
