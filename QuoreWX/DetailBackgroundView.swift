//
//  DetailBackgroundView.swift
//  QuoreWX
//
//  Created by Paul Adams on 8/8/19.
//  Copyright © 2019 Paul Adams. All rights reserved.
//

import UIKit
import CoreGraphics

class DetailBackgroundView: UIView {
    
    override func draw(_ rect: CGRect) {

        // Color Declarations
        let quoreGreenLight: UIColor = UIColor(red:0.36, green:0.70, blue:0.02, alpha:1.0)
        let quoreGreenDark: UIColor = UIColor(red:0.20, green:0.34, blue:0.08, alpha:1.0)
        
        let context = UIGraphicsGetCurrentContext()
        
        // Gradient Declarations
        let quoreGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [quoreGreenLight.cgColor, quoreGreenDark.cgColor] as CFArray, locations: [0, 1])
        
        // Background Drawing
        let backgroundPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        let options: CGGradientDrawingOptions = [.drawsBeforeStartLocation, .drawsAfterEndLocation]
        context?.saveGState()
        backgroundPath.addClip()
        context?.drawLinearGradient(quoreGradient!,
                                    start: CGPoint(x: 160, y: 0),
                                    end: CGPoint(x: 160, y: 568),
                                    options: options.self)
        context?.restoreGState()
        
        // Sun Path
        
        let circleOrigin = CGPoint(x: 0, y: 0.80 * self.frame.height)
        let circleSize = CGSize(width: self.frame.width, height: 0.65 * self.frame.height)
        
        let pathStrokeColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.390)
        let pathFillColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.100)
        
        // Sun Drawing
        let sunPath = UIBezierPath(ovalIn: CGRect(x: circleOrigin.x, y: circleOrigin.y, width: circleSize.width, height: circleSize.height))
        pathFillColor.setFill()
        sunPath.fill()
        pathStrokeColor.setStroke()
        sunPath.lineWidth = 1
        context?.saveGState()
        context?.setLineDash(phase: 0, lengths: [2, 2])
        sunPath.stroke()
        context?.restoreGState()
        
    }
}
