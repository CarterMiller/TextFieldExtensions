//
//  UITextFieldExtendedMultiPopup.swift
//  TextFieldExtensions
//
//  Created by Russell Morgan on 21/01/2017.
//  Copyright © 2017 Carter Miller. All rights reserved.
//

//
//  UITextFieldExtendedViewPopup.swift
//  TextFieldExtensions
//
//  Created by Russell Morgan on 19/01/2017.
//  Copyright © 2017 Carter Miller. All rights reserved.
//


import UIKit
import QuartzCore


extension UITextFieldExtendedView 
{
    
    // setup
    func setupPopup(dataSet : [String], dataSetSelected : [String])
    {
        self.dataSet            = dataSet
        self.dataSetSelected    = dataSetSelected
        setupPopup()
    }
    func setupPopup(dataSet : [String], dataSetSelected : [String], delegate : UITextFieldExtendedDelegate)
    {
        self.dataSet            = dataSet
        self.dataSetSelected    = dataSetSelected
        self.delegatePopup  =   delegate
        setupPopup()
    }
    func setupPopup(dataSet : [String], dataSetSelected : [String], controlTag: Int)
    {
        self.dataSet            = dataSet
        self.dataSetSelected    = dataSetSelected
        self.tag                = controlTag
        setupPopup()
    }
    func setupPopup(dataSet : [String], dataSetSelected : [String], controlTag: Int, delegate : UITextFieldExtendedDelegate)
    {
        self.dataSet            = dataSet
        self.dataSetSelected    = dataSetSelected
        self.tag                = controlTag
        self.delegatePopup      = delegate
        setupPopup()
    }
    
    
    func displayMultiPopup()
    {
        if !shouldDisplayPopup
        {
            return
        }
        
        if dataSetSelected == nil
        {
            return
        }
        // hide the keyboard
        // this is NOT an ideal situation, as the UIView now thinks this control
        // has finished editing, but it;s the only way I can find to hide the keyboard :-(
        _ = self.resignFirstResponder()
        
        // initialise dataSetSelectedFlag
        
        dataSetSelectedFlag.removeAll()
        for dataEntry in dataSet
        {
            dataSetSelectedFlag.append((dataSetSelected?.contains(dataEntry))!)
        }

        numberOfLines = dataSet.count + 4
        if numberOfLines < 2
        {
            numberOfLines = 2
        }
        if numberOfLines > 12
        {
            numberOfLines = 12
        }
        
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
        
        let viewDisplay = UIView(frame: viewPopup.bounds)
        viewDisplay.backgroundColor = UIColor(white: 1, alpha: 1)
        
        viewDisplay.layer.cornerRadius = 10.0
        viewDisplay.layer.borderColor = shadowColor.cgColor
        viewDisplay.layer.borderWidth = 0.5
        viewDisplay.clipsToBounds = true
        
        
        viewMultiPopup = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        let tapGesturePopup = UITapGestureRecognizer(target: self, action: #selector(self.popupTapped(_:)))
        viewPopup.addGestureRecognizer(tapGesturePopup)

        
        // add label and switch for each dataSet
        // set switch value based on dataSetSelected
        
        // this will only work for a small number of entries
        // need something to trap this
        if dataSet.count > 0
        {
            let xLabel      = CGFloat(20)
            var yLabel      = CGFloat(20)
            let xSwitch     = width - CGFloat(70)
            
            let ySpacing    = self.frame.size.height + 5
            
            for (index, dataEntry) in dataSet.enumerated()
            {
                let label = UILabel(frame: CGRect(x: xLabel, y: yLabel, width: xSwitch - xLabel, height: 20))
                label.text = dataEntry
                print(label.frame)
            
                let dataSwitch = UISwitch(frame: CGRect(x: xSwitch, y: yLabel, width: 100, height: 15))
                //dataSwitch.setOn(dataSetSelected!.contains(dataEntry), animated: true)
                dataSwitch.setOn(dataSetSelectedFlag[index], animated: true)
                
                dataSwitch.tag = index
                dataSwitch.addTarget(self, action: #selector(UITextFieldExtendedView.switchChanged(_:)), for: UIControlEvents.allEvents)
                
                viewMultiPopup.addSubview(label)
                viewMultiPopup.addSubview(dataSwitch)
                
                yLabel += ySpacing
            }
            
            let cmdOK = UIButton(frame: CGRect(x: (width - 100) / 2, y: height - 40, width: 100, height: 30))
            cmdOK.setTitle("OK", for: .normal)
            cmdOK.setTitleColor(UIColor.black, for: .normal)
            cmdOK.addTarget(self, action:#selector(self.cmdOK), for: .touchUpInside)

            viewMultiPopup.addSubview(cmdOK)
        }
        viewDisplay.addSubview(viewMultiPopup)
        
        
        if shouldDisplayGlow
        {
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = viewPopup.bounds
            viewPopup.addSubview(blurEffectView)
            
            let shadowFrame = CGRect(x: 0, y: 0, width: width, height: height)
            let shadowView = UIView(frame: shadowFrame)
            shadowView.layer.shadowColor = shadowColor.cgColor
            shadowView.layer.shadowOffset = CGSize.zero
            shadowView.layer.shadowOpacity = 1.0
            shadowView.layer.shadowRadius = shadowWidth
            
            viewPopup.addSubview(shadowView)
            shadowView.addSubview(viewDisplay)
            
            showShadow(shadowView)
        }
        else
        {
            viewPopup.addSubview(viewDisplay)
        }
        
        self.superview?.addSubview(viewPopup)
        
    }


    func switchChanged(_ mySwitch: UISwitch!)
    {
        print("switch")
        let index = mySwitch.tag
        dataSetSelectedFlag[index] = !dataSetSelectedFlag[index]
    }

    func popupTapped(_ sender: UITapGestureRecognizer)
    {
        // don't go away if the control tapped is on viewDisplay
        print("popup")
        print(sender.view?.frame)
    }
    
    func cmdOK(sender: UIButton!)
    {
        print("OK")
        var returnArray : [String] = []
        for (index, dataEntry) in dataSet.enumerated()
        {
            if dataSetSelectedFlag[index]
            {
                returnArray.append(dataEntry)
            }
        }
        
        delegatePopup!.multiPopupUpdated!(valueReturn: returnArray, controlTag: self.tag, valueChanged: true)

        self.removePopup()
    }
}
