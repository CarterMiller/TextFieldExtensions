//
//  TextFieldGlow.swift
//  TextFieldPopupView
//
//  Created by Russell Morgan on 17/01/2017.
//  Copyright © 2017 Carter Miller. All rights reserved.
//

import UIKit

@IBDesignable class TextFieldGlow: UITextField
{

    // optional parameters
    @IBInspectable var shadowColor: UIColor = UIColor(red: 82.0 / 255.0, green: 168.0 / 255.0, blue: 236.0 / 255.0, alpha: 0.8)
    @IBInspectable var animationDuration   : Double   = 0.2
    @IBInspectable var shadowWidth : CGFloat   = 10.0
    
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder:NSCoder)
    {
        super.init(coder:aDecoder)
    }



    // ANIMATION
    func setupShadow()
    {
        if self.backgroundColor == nil
        {
            self.backgroundColor = UIColor.white
        }
        
        self.clipsToBounds = true
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowPath =  UIBezierPath(roundedRect: self.layer.bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 4, height: 4)).cgPath
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = self.shadowWidth
        self.layer.shadowOpacity = 1.0
    }
    
    func showShadow()
    {
        setupShadow()
        animateBorderColorFrom(fromColor: self.backgroundColor!, toColor: UIColor(cgColor: self.layer.shadowColor!), fromOpacity: 0.0, toOpacity: 1.0)
    }
    
    
    func hideShadow()
    {
        animateBorderColorFrom(fromColor: UIColor(cgColor: self.layer.shadowColor!), toColor: self.backgroundColor!, fromOpacity: 1.0, toOpacity: 0.0)
    }
    
    func animateBorderColorFrom(fromColor : UIColor, toColor : UIColor, fromOpacity : CGFloat, toOpacity : CGFloat)
    {
        let borderColorAnimation = CABasicAnimation(keyPath: "borderColor")
        borderColorAnimation.fromValue = fromColor
        borderColorAnimation.toValue = toColor
        
        let shadowOpacityAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        shadowOpacityAnimation.fromValue = fromOpacity
        shadowOpacityAnimation.toValue = toOpacity
        
        let group = CAAnimationGroup()
        group.duration = animationDuration
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        group.isRemovedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        group.animations = [borderColorAnimation, shadowOpacityAnimation]
        
        self.layer.add(group, forKey: nil)
    }

    // overrides
    override func becomeFirstResponder() -> Bool
    {
        let result : Bool = super.becomeFirstResponder()
        
        if result
        {
            self.showShadow()
        }
        return result
    }
    
    override func resignFirstResponder() -> Bool
    {
        let result : Bool = super.resignFirstResponder()
        
        if result
        {
            self.hideShadow()
        }
        return result
    }
    

    
 }
