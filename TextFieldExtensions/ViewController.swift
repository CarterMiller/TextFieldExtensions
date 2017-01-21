//
//  ViewController.swift
//  TextFieldPopupView
//
//  Created by Russell Morgan on 16/01/2017.
//  Copyright © 2017 Carter Miller. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate, UITextFieldExtendedDelegate
{

    @IBOutlet weak var textField1: UITextFieldExtendedView!
    @IBOutlet weak var textField2: UITextFieldExtendedView!
    @IBOutlet weak var textField3: UITextFieldExtendedView!
    @IBOutlet weak var textField4: UITextFieldExtendedView!
    @IBOutlet weak var textField5: UITextFieldExtendedView!
    @IBOutlet weak var textField6: UITextFieldExtendedView!
       
    var sampleData1 = ["one", "two", "three", "four", "five"]
    var sampleData2 = ["cat", "dog", "mouse", "horse", "hamster", "snake"]
    var sampleData3 = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var dataSelected = ["Monday", "Wednesday", "Saturday"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // set up the popup data.  You can do this at any time
        textField2.setupPopup(dataSet: sampleData2, controlTag: 2,  delegate: self)
        textField3.setupPopup(dataSet: sampleData3, controlTag: 3,  delegate: self)
        
        textField6.setupPopup(dataSet: sampleData3, dataSetSelected: dataSelected, controlTag: 5,  delegate: self)

        // but to stop editing when the user taps anywhere on the view, add this gesture recogniser
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        self.view.addGestureRecognizer(tapGestureBackground)
        
    }
    
    func backgroundTapped(_ sender: UITapGestureRecognizer)
    {
        // don't go away if the control tapped is on viewDisplay
        print(sender.view?.frame)
        
        view.endEditingWithPopups(true)       // end editing for any UITextField controls, and also for standard controls
    }
    
    // UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return false
    }
    
    // UITextFieldExtendedDelegate
    
    func multiPopupUpdated(valueReturn: [String], controlTag: Int, valueChanged: Bool)
    {
        var text : String = ""
        
        for textReturn in valueReturn
        {
            text = text + textReturn
            
        }
        if controlTag == 5
        {
            textField6.text = text
        }
    }
    
    func popupPickerViewChanged(valueReturn : String, controlTag : Int, valueChanged : Bool)
    {
        if valueChanged == false
        {
            return
        }
        
        print(controlTag)
        
        if controlTag == 1
        {
            // do something for control 1
        }
        if controlTag == 2
        {
            // do something for control 2
        }
        if controlTag == 3
        {
            // do something for control 3
        }
    }
 
    
    
}

