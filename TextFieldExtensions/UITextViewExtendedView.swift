//
//  UITextViewExtendedView.swift
//  TextFieldExtensions
//
//  Created by Russell Morgan on 12/06/2017.
//  Copyright © 2017 Carter Miller. All rights reserved.
//


import UIKit
import QuartzCore



@IBDesignable class UITextViewExtendedView: UITextView
{
    // define text field type
    @IBInspectable var shouldDisplayGlow : Bool    = false
    
    // general
    
    @IBInspectable var animationDuration : Double   = 0.2
    @IBInspectable var shadowColor : UIColor = UIColor(red: 82.0 / 255.0, green: 168.0 / 255.0, blue: 236.0 / 255.0, alpha: 0.8)
    
    // glowing border declarations
    let shadowWidth : CGFloat   = 10.0

    var blurEffectView: UIVisualEffectView!
    
    // MARK:- Init
    required init(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?)
    {
        super.init(frame: CGRect.zero, textContainer: nil)
    }
    
    // in use
    override open func becomeFirstResponder() -> Bool
    {
        let result : Bool = super.becomeFirstResponder()
        // if we should show glowing border, handle that
        if shouldDisplayGlow
        {
            self.showBorder()
        }
        
        return result
    }
    
    
    override func resignFirstResponder() -> Bool
    {
        let result : Bool = super.resignFirstResponder()
        
        if result
        {
            if shouldDisplayGlow
            {
                self.hideBorder()
            }
        }
        return result
    }
    
    
}

