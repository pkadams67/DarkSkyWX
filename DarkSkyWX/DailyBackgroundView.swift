import CoreGraphics
import UIKit

class DailyBackgroundView: UIView {

	override func draw(_ rect: CGRect) {

		// Color Declarations
		let darkSkyLightGray = UIColor.lightGray
		let darkSkyDarkGray = UIColor.darkGray
		let context = UIGraphicsGetCurrentContext()

		// Gradient Declarations
		let darkSkyGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [darkSkyLightGray.cgColor, darkSkyDarkGray.cgColor] as CFArray, locations: [0, 1])

		// Background Drawing
		let backgroundPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
		let options: CGGradientDrawingOptions = [.drawsBeforeStartLocation, .drawsAfterEndLocation]
		context?.saveGState()
		backgroundPath.addClip()
		context?.drawLinearGradient(darkSkyGradient!,
		                            start: CGPoint(x: 160, y: 0),
		                            end: CGPoint(x: 160, y: 568),
		                            options: options.self)
		context?.restoreGState()

		// Sun Path
		let circleOrigin = CGPoint(x: 0, y: 0.8 * frame.height)
		let circleSize = CGSize(width: frame.width, height: 0.65 * frame.height)
		let pathStrokeColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
		let pathFillColor = UIColor(red: 0.2, green: 0.67, blue: 0.83, alpha: 0.25)

		// Sun Drawing
		let sunPath = UIBezierPath(ovalIn: CGRect(x: circleOrigin.x, y: circleOrigin.y, width: circleSize.width, height: circleSize.height))
		pathFillColor.setFill()
		sunPath.fill()
		pathStrokeColor.setStroke()
		sunPath.lineWidth = 2
		context?.saveGState()
		context?.setLineDash(phase: 0, lengths: [10, 5])
		sunPath.stroke()
		context?.restoreGState()
	}
}
