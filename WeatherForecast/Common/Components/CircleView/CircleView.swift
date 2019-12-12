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
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
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
    let dotPath = UIBezierPath(ovalIn:rect)
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = dotPath.cgPath
    shapeLayer.fillColor = mainColor.cgColor
    layer.addSublayer(shapeLayer)
    
    if (isSelected) { drawRingFittingInsideView(rect: rect) }
  }
  
  internal func drawRingFittingInsideView(rect: CGRect)->()
  {
    let hw:CGFloat = ringThickness/2
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
