//
//  CircleView.swift
//  WeatherForecast
//
//  Created by Dilip Kosuri on 9/12/19.
//  Copyright © 2019 Dilip Kosuri. All rights reserved.
//

import UIKit
@IBDesignable
final class CircleView: UIView {
  
  // Dot with border, which you can control completely in Storyboard
  @IBInspectable var mainColor: UIColor = UIColor.blue
    {
    didSet { print("mainColor was set here") }
  }
  @IBInspectable var ringColor: UIColor = UIColor.orange
    {
    didSet { print("bColor was set here") }
  }
  @IBInspectable var ringThickness: CGFloat = 4
    {
    didSet { print("ringThickness was set here") }
  }
  
  override func layoutSubviews() {
    layer.cornerRadius = bounds.size.width/2;
  }
  
  @IBInspectable var isSelected: Bool = true
  
  override func draw(_ rect: CGRect)
  {
    
    let colorTop =  UIColor(red: 69.0/255.0, green: 104.0/255.0, blue: 220.0/255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 176.0/255.0, green: 106.0/255.0, blue: 179.0/255.0, alpha: 1.0).cgColor
    
    // Start and finish point
    let startPoint = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
    let finishPoint = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
    
    
    let dotPath = UIBezierPath(ovalIn:rect)
    
    dotPath.move(to: startPoint)
    dotPath.addLine(to: finishPoint)
    
    
    let gradientMask = CAShapeLayer()
    let lineHeight = self.frame.height
    gradientMask.fillColor = mainColor.cgColor
    gradientMask.strokeColor = UIColor.black.cgColor
    gradientMask.lineWidth = lineHeight
    gradientMask.frame = self.bounds
    gradientMask.path = dotPath.cgPath
    
    
    // Gradient Layer
    let gradientLayer = CAGradientLayer()
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    
    // make sure to use .cgColor
    gradientLayer.colors = [colorTop, colorBottom]
    gradientLayer.frame = self.bounds
    gradientLayer.mask = gradientMask
    
    self.layer.addSublayer(gradientLayer)
    
    // Corner radius
    self.layer.cornerRadius = 10
    self.clipsToBounds = true
    
    // Filling animation
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.fromValue = 100
    animation.duration = 1000
    gradientMask.add(animation, forKey: "LineAnimation")
    
    if (isSelected) { drawRingFittingInsideView(rect: rect) }
  }
  
  internal func drawRingFittingInsideView(rect: CGRect)->()
  {
    let hw:CGFloat = ringThickness/3
    let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: hw,dy: hw) )
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = circlePath.cgPath
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = ringColor.cgColor
    shapeLayer.lineWidth = ringThickness
    layer.addSublayer(shapeLayer)
  }
  
  // MARK: - Initializers
  
  override init(frame: CGRect) {
      super.init(frame: frame)
      
      configure()
  }
  
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      
      configure()
  }
  
  private func configure() {
      addGestureRecognizer(
          UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
      )
  }
  
  // MARK: - Actions
  
  @objc
  private func didTap(recognizer: UITapGestureRecognizer) {
     
  }
  
}
