//
//  GraphView.swift
//  GraphView
//
//  Created by Diego Costa on 22/11/18.
//  Copyright © 2018 Diego Costa. All rights reserved.
//

import UIKit

struct GraphModel {
    var amount : CGFloat = 100
    var value : CGFloat = 1
    var missing  : CGFloat = 0
}

typealias BezierPaths = (UIBezierPath, UIBezierPath)

class GraphView : UIView {
    private var amountShape  : CAShapeLayer = CAShapeLayer()
    private var valueShape   : CAShapeLayer = CAShapeLayer()
    private var missingShape : CAShapeLayer = CAShapeLayer()
    
    private lazy var amountPath   : BezierPaths = {
        let start = CGRect(x: 0, y: frame.height, width: frame.width, height: 1)
        let end   = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
       return (UIBezierPath(rect: start), UIBezierPath(rect: end))
    }()
    
    private lazy var valuePath   : BezierPaths = {
        let start = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        let end   = CGRect(x: 0, y: frame.height / 2, width: frame.width, height: frame.height / 2)
        return (UIBezierPath(rect: start), UIBezierPath(rect: end))
    }()
    
    private lazy var missingPath   : BezierPaths = {
        let start = CGRect(x: 0, y: frame.height - 2, width: frame.width, height: 1)
        let end   = CGRect(x: 0, y: frame.height / 3, width: frame.width, height: frame.height / 3)
        return (UIBezierPath(rect: start), UIBezierPath(rect: end))
    }()
    
    
    open var animationDuration : CFTimeInterval = 1
    
    private var model : GraphModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareLayout() {

        self.amountShape.lineDashPattern  = [2, 2]
        self.amountShape.strokeColor      = #colorLiteral(red: 0.9734560847, green: 0.5069215894, blue: 0.002371474402, alpha: 1)
        self.amountShape.fillColor        = UIColor.clear.cgColor
        
        self.valueShape.strokeColor      = #colorLiteral(red: 0.9734560847, green: 0.5069215894, blue: 0.002371474402, alpha: 1)
        self.valueShape.fillColor        = #colorLiteral(red: 0.9734560847, green: 0.5069215894, blue: 0.002371474402, alpha: 1)
        
        self.missingShape.lineDashPattern  = [6, 6]
        self.missingShape.strokeColor      = #colorLiteral(red: 0.9734560847, green: 0.5069215894, blue: 0.002371474402, alpha: 1)
        self.missingShape.fillColor        = UIColor.clear.cgColor
        self.missingShape.lineWidth        = 1.4
        
        self.layer.addSublayer(amountShape)
        self.layer.addSublayer(valueShape)
        self.layer.addSublayer(missingShape)
        
        self.animation(amountShape, paths: amountPath, timing: 0)
        self.animation(valueShape, paths: valuePath, timing: 1.5)
        self.animation(missingShape, paths: missingPath, timing: 2.5)
    }
    
    private func animation(_ shape : CAShapeLayer, paths : BezierPaths, timing : CFTimeInterval) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "path")
        animation.duration  = animationDuration
        animation.fromValue = paths.0.cgPath
        animation.toValue   = paths.1.cgPath
        animation.fillMode  = kCAFillModeBackwards
        animation.beginTime = CACurrentMediaTime() + timing
        
        shape.path = paths.1.cgPath
        shape.add(animation, forKey: nil)
    }
}
