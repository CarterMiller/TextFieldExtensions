//
//  TextFieldPopupView.swift
//
//  Created by Russell D Morgan on 13.01.17.
//  Copyright © 2017 Carter Miller. All rights reserved.
//


import UIKit
protocol TextFieldPopupViewDelegate
{
    func popupPickerViewChanged(valueReturn : String, controlTag: Int, valueChanged : Bool)
}

@IBDesignable class TextFieldPopupView: UITextField, UIPickerViewDelegate, UIPickerViewDataSource
{

    var shadowColor = UIColor(red: 82.0 / 255.0, green: 168.0 / 255.0, blue: 236.0 / 255.0, alpha: 0.8).cgColor
    let shadowWidth : CGFloat   = 10.0

    var dataSet : [String]      = []
    var valueInit : String      = ""
    
    var pickerView : UIPickerView = UIPickerView()
    var blurEffectView: UIVisualEffectView!
    var viewPopup = UIView()
    
    var delegatePopup : TextFieldPopupViewDelegate!

    // optional parameters
    @IBInspectable var numberOfLines            : Int       = 5
    @IBInspectable var animationDurationPopup   : Double   = 0.2
    
    func setup(dataSet : [String])
    {
        self.dataSet = dataSet
        
        setup()
    }
    
    func setup(dataSet : [String], delegate : TextFieldPopupViewDelegate)
    {
        self.dataSet        = dataSet
        self.delegatePopup  = delegate
        
        setup()
    }
    
    func setup(dataSet : [String], controlTag: Int)
    {
        self.dataSet        = dataSet
        self.tag            = controlTag
        
        setup()
    }

    func setup(dataSet : [String], controlTag: Int, delegate : TextFieldPopupViewDelegate)
    {
        self.dataSet        = dataSet
        self.tag            = controlTag
        self.delegatePopup  = delegate

        setup()
    }

    func setup()
    {
        if numberOfLines < 1
        {
            numberOfLines = 1
        }
        
        if numberOfLines > 12
        {
            numberOfLines = 12
        }

        self.valueInit      = self.text!
    }
        
    func removePopup()
    {
        viewPopup.removeFromSuperview()
    }
    
    func displayPopup()
    {
        // hide the keyboard
        // this is NOT an ideal situation, as the UIView now thinks this control
        // has finished editing, but it;s the only way I can find to hide the keyboard :-(
        _ = self.resignFirstResponder()
        
        let width   = self.frame.size.width
        let height  = self.frame.size.height * CGFloat(numberOfLines)
        
        var originX = self.frame.origin.x
        var originY = self.frame.origin.y + self.frame.height / 2 - height / 2
        
        if originX < 0
        {
            originX = 10
        }
        if originX + width > UIScreen.main.bounds.width
        {
            originX = UIScreen.main.bounds.width - width
        }

        if originY < 0
        {
            originY = 10
        }
        if originY + height > UIScreen.main.bounds.height
        {
            originY = UIScreen.main.bounds.height - height
        }

        let frameRect = CGRect(x: originX, y: originY, width: width, height: height)
        
        viewPopup = UIView(frame: frameRect)
        
        viewPopup.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewPopup.bounds
        viewPopup.addSubview(blurEffectView)

        let shadowFrame = CGRect(x: 0, y: 0, width: width, height: height)
        let shadowView = UIView(frame: shadowFrame)
        shadowView.layer.shadowColor = shadowColor
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowOpacity = 1.0
        shadowView.layer.shadowRadius = shadowWidth
        
        let viewDisplay = UIView(frame: shadowView.bounds)
        viewDisplay.backgroundColor = UIColor(white: 1, alpha: 1)
        
        viewDisplay.layer.cornerRadius = 10.0
        viewDisplay.layer.borderColor = shadowColor
        viewDisplay.layer.borderWidth = 0.5
        viewDisplay.clipsToBounds = true
        
        viewPopup.addSubview(shadowView)
        shadowView.addSubview(viewDisplay)
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(findIndexInitial(), inComponent: 0, animated: true)
        
        viewDisplay.addSubview(pickerView)
    
        self.superview?.addSubview(viewPopup)
        
        showShadow(shadowView)
        
    }
   
    func findIndexInitial() -> Int
    {
        for (index, val) in dataSet.enumerated()
        {
            if val == valueInit
            {
                return index
            }
        }
        return 0
        
    }
    
    // ANIMATION
    func showShadow(_ view: UIView)
    {
        
        let animation = CABasicAnimation(keyPath: "shadowRadius")
        animation.duration  = self.animationDurationPopup
        animation.fromValue = 0
        animation.toValue   = shadowWidth
        view.layer.add(animation, forKey: "shadowRadius")
        
    }
    
    // PickerView methods
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        
        pickerLabel.text = dataSet[row]
        
        pickerLabel.font = self.font // self.control.font
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.text = dataSet[row]
        
        delegatePopup.popupPickerViewChanged(valueReturn: dataSet[row], controlTag: self.tag, valueChanged: (dataSet[row] != valueInit))
        valueInit = dataSet[row]
        self.removePopup()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return dataSet.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return dataSet[row]
    }
    
    
    // MARK:- Init
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
    }
    
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }

}

extension UITextField
{
    override open func becomeFirstResponder() -> Bool
    {
        let result : Bool = super.becomeFirstResponder()
        
        if result
        {
            // remove any popups that have already been displayed by other controls
            // and present the popup for self
            for subView in self.superview!.subviews
            {
                if let control = subView as? TextFieldPopupView
                {
                    if control.tag == self.tag
                    {
                        control.displayPopup()
                    }
                    else
                    {
                        control.removePopup()
                    }
                }
            }
        }
        return result
    }

}

extension UIView
{
    func endEditingWithPopups(_ force: Bool)
    {
        // end editing for everything else on the view
        self.endEditing(true)
        
        // now take care of any TextFieldPopupView
        for subView in self.subviews
        {
            if let control = subView as? TextFieldPopupView
            {
                control.removePopup()
            }
        }
    }
    
}

