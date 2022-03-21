import UIKit

class WeeklyBackgroundView: UIView {

	override func draw(_ rect: CGRect) {

		// Background View

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
	}
}
