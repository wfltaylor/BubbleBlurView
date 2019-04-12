//
//  BubbleBlurView.swift
//  Bubbles Floating Test App
//
//  Created by William Taylor on 11/4/19.
//  Copyright © 2019 William Taylor. All rights reserved.
//

import UIKit

/// (Position x in view, Position y in view, Bubble color, Bubble size, Movement direction, Radius multiplier) - All properties represented relative to the
public typealias Bubble = (Double, Double, UIColor, Double, Double, Double)

/// An Apple Card style UIView
open class BubbleBlurView: UIView {
    
    //MARK: Variables
    
    /// The standard bubbles
    static private let defaultBubbles = [(0.0, 0.061, UIColor.red, 0.5, -1.0, 0.5), (0.26, 0.369, UIColor.green, 0.33, 1.0, 0.5), (0.4, 0.61, UIColor.orange, 0.5, 1.0, 1.5), (0.26, 0.61, UIColor.yellow, 0.67, -1.0, 1.2), (0.5, -0.1, UIColor.blue, 0.35, 1.0, 0.3)]
    
    /// The bubbles that will be drawn to the screen
    open var initialBubbles: [Bubble] = defaultBubbles
    
    /// The bubbles currently drawn
    open var bubbles: [Bubble] = []
    
    private var lastDisplay = 0.0
    
    private var currentValue = 0.0
    
    private var negativeFlag = false
    
    private var displayLink: CADisplayLink?
    
    //MARK: Overriden Methods
    
    override open func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(rect: rect)
        
        UIColor.white.set()
        path.fill()
        
        context?.draw(createBubbbleImage(), in: rect)
    }
    
    open override func layoutSubviews() {
        //Reset on change of size
        bubbles = initialBubbles
        super.layoutSubviews()
    }
    
    //MARK: Public
    
    /// Starts rendering the bubbles onto the screen
    open func startBubbles(_ bubbles: [Bubble]? = nil) {
        if let bubbles = bubbles {
            initialBubbles = bubbles
        } else {
            initialBubbles = type(of: self).defaultBubbles
        }
        self.bubbles = initialBubbles
        
        createDisplayLink()
    }
    
    /// Stops animating the bubbles
    open func stopBubbles() {
        destroyDisplayLink()
    }
    
    //MARK: Private
    
    /// Draws an image of the bubbles
    ///
    /// - Returns: The image of the bubbles
    private func createBubbbleImage() -> CGImage {
        UIGraphicsBeginImageContext(frame.size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        //Calculate scale of frame
        let scale = Double((frame.size.width + frame.size.height) / 2)
        
        for bubble in bubbles {
            //Draw bubble
            
            let rect = CGRect(x: bubble.0 * Double(frame.size.width), y: bubble.1 * Double(frame.size.height), width: bubble.3 * scale, height: bubble.3 * scale)
            context?.setFillColor(bubble.2.cgColor)
            context?.setAlpha(0.7)
            context?.fillEllipse(in: rect)
        }
        
        context?.restoreGState()
        
        //Create image from context
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //How much to crop the image
        let subtractor = (x: frame.size.width * 0.2, y: frame.size.width * 0.2)
        
        //Blur and adjust brightness
        let blurred = CoreImage.image(image.cgImage!).blur(withRadius: CGFloat(0.12/*0.08424599832*/ * scale)).cropped(to: CGRect(x: subtractor.x, y: subtractor.y, width: frame.size.width - subtractor.x, height: frame.size.height - subtractor.y)).changeBrightness(toValue: 0.07).cgImage
        
        return blurred
    }
    
    private func createDisplayLink() {
        //Setup the display link
        
        displayLink = CADisplayLink(target: self,
                                        selector: #selector(step))
        
        let displayLink = self.displayLink!
        
        displayLink.add(to: .current,
                        forMode: RunLoop.Mode.default)
    }
    
    private func destroyDisplayLink() {
        guard let displayLink = displayLink else { return }
        
        displayLink.invalidate()
        
        self.displayLink = nil
    }
    
    @objc
    private func step(displaylink: CADisplayLink) {
        //Set the initial display link value
        if lastDisplay == 0.0 {
            lastDisplay = displaylink.timestamp
        }
        
        //How long has passed since the last display link?
        let difference = (displaylink.timestamp - lastDisplay)
        
        //Subtract or add to current x value
        if negativeFlag {
            currentValue -= difference
        } else {
            currentValue += difference
        }
        
        //Calculate the radius from the view frame
        let radius = Double(0.003369839933 * ((frame.size.width + frame.size.height) / 2))
        
        //Reset the current value if it exceeds the radius bounds
        if currentValue >= radius {
            currentValue = radius
            negativeFlag.toggle()
        } else if currentValue <= -radius {
            currentValue = -radius
            negativeFlag.toggle()
        }
        
        let x = currentValue
        
        //Calculate y value on circular path from x value
        let y = negativeFlag ? -sqrt((radius * radius)-(x*x)) : sqrt((radius * radius)-(x*x))
        
        for i in 0..<bubbles.count {
            bubbles[i].0 = bubbles[i].0 + ((x * bubbles[i].4 * bubbles[i].5) / Double(frame.size.width))
            bubbles[i].1 = bubbles[i].1 + ((y * bubbles[i].4 * bubbles[i].5) / Double(frame.size.height))
        }
        
        //Store the current display link value for next time
        lastDisplay = displaylink.timestamp
        
        //Redraw the view
        self.setNeedsDisplay()
    }
    
}
