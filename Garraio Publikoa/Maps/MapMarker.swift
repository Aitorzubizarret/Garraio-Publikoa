//
//  MapMarker.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 22/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit

class MapMarker {
    
    ///
    /// Creates an image that will be used as a marker in the map.
    /// - Parameter text: A text string we want to draw on the image.
    /// - Returns: An image.
    ///
    public func createImageWithText(text: String) -> UIImage {
        
        // Values.
        let imageHeight = 35
        let imageWidth = 32
        
        // Main Layer.
        let mainLayer: CALayer = CALayer()
        mainLayer.drawsAsynchronously = true
        mainLayer.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        mainLayer.cornerRadius = 10
        mainLayer.backgroundColor = UIColor.clear.cgColor
        
        // Square Layer.
        let squareLayer: CALayer = CALayer()
        squareLayer.drawsAsynchronously = true
        squareLayer.frame = CGRect(x: 2, y: 0, width: imageWidth - 4, height: imageHeight - 8)
        squareLayer.cornerRadius = 8
        squareLayer.backgroundColor = UIColor.markerRed.cgColor
        squareLayer.shadowOffset = CGSize(width: 0, height: 2)
        squareLayer.shadowRadius = 1.5
        squareLayer.shadowOpacity = 0.3
        squareLayer.shadowColor = UIColor.gray.cgColor
        
        // Text Layer.
        let textLayer = CATextLayer()
        textLayer.drawsAsynchronously = true
        textLayer.frame = CGRect(x: 5, y: 6, width: imageWidth - 10, height: imageHeight - 10)
        textLayer.string = text.uppercased()
        textLayer.fontSize = 10
        textLayer.alignmentMode = .center
        textLayer.foregroundColor = UIColor.white.cgColor

        // Triangle Shape.
        let triangleShape: CAShapeLayer = CAShapeLayer()
        triangleShape.drawsAsynchronously = true
        triangleShape.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: (imageWidth / 2), y: imageHeight))
        trianglePath.addLine(to: CGPoint(x: (imageWidth / 2) - 5, y: imageHeight - 10))
        trianglePath.addLine(to: CGPoint(x: (imageWidth / 2) + 5, y: imageHeight - 10))
        trianglePath.addLine(to: CGPoint(x: (imageWidth / 2), y: imageHeight))
        trianglePath.close()
        
        triangleShape.path = trianglePath.cgPath
        triangleShape.fillColor = UIColor(red: 0.95, green: 0.37, blue: 0.36, alpha: 1.00).cgColor
        triangleShape.shadowOffset = CGSize(width: 0, height: 2)
        triangleShape.shadowRadius = 1.5
        triangleShape.shadowOpacity = 0.3
        triangleShape.shadowColor = UIColor.gray.cgColor
        
        // Add all layers into the main.
        mainLayer.addSublayer(squareLayer)
        mainLayer.addSublayer(textLayer)
        mainLayer.addSublayer(triangleShape)

        // Convert CALayer to UIImage.
        UIGraphicsBeginImageContext(CGSize(width: imageWidth, height: imageHeight))
        mainLayer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let marker = outputImage else {
            return UIImage(named: "marker")!
        }
        
        return marker
    }
    
    ///
    /// Creates an small image that will be used as a marker in the map.
    ///
    public func createSmallRoundedImageWithColor(color: UIColor) -> UIImage {
        
        // Values.
        let imageHeight = 16
        let imageWidth = 16
        
        // Main Layer.
        let mainLayer: CALayer = CALayer()
        mainLayer.drawsAsynchronously = true
        mainLayer.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        mainLayer.cornerRadius = 10
        mainLayer.backgroundColor = UIColor.clear.cgColor
        
        // Circle Layer.
        let circleLayer: CALayer = CALayer()
        circleLayer.drawsAsynchronously = true
        circleLayer.frame = CGRect(x: 0, y: 0, width: (imageWidth - 2), height: (imageHeight - 2))
        circleLayer.cornerRadius = CGFloat(imageWidth / 2)
        circleLayer.backgroundColor = color.cgColor
        circleLayer.borderWidth = 0.6
        circleLayer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        
        // Add all layers into the main.
        mainLayer.addSublayer(circleLayer)

        // Convert CALayer to UIImage.
        UIGraphicsBeginImageContext(CGSize(width: imageWidth, height: imageHeight))
        mainLayer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let marker = outputImage else {
            return UIImage(named: "marker")!
        }
        
        return marker
    }
}
