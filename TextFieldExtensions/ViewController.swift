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
        textField2.setupPopup(dataSet: sampleData2, controlTag: textField2.tag,  delegate: self)
        textField3.setupPopup(dataSet: sampleData3, controlTag: textField3.tag,  delegate: self)
        
        textField6.setupPopup(dataSet: sampleData3, dataSetSelected: dataSelected, controlTag: 5,  delegate: self)

        // but to stop editing when the user taps anywhere on the view, add this gesture recogniser
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        self.view.addGestureRecognizer(tapGestureBackground)
        
    }
    
    
    func backgroundTapped(_ sender: UITapGestureRecognizer)
    {
        view.endEditingWithPopups(true)       // end editing for any UITextField controls, and also for standard controls
    }
    
    // UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return false
    }

    // UITextFieldExtendedDelegate
    
    func multiPopupUpdated(valueReturn: [String], control: UITextFieldExtendedView, valueChanged: Bool)
    {
        var text : String = ""

        for dataEntry in valueReturn
        {
            text += dataEntry
            
            if dataEntry != valueReturn.last
            {
                text += ", "
            }
        }

        if control.tag == 5
        {
            control.text = text
        }
    }
    
    func popupPickerViewChanged(valueReturn : String, control : UITextFieldExtendedView, valueChanged : Bool)
    {
        if valueChanged == false
        {
            return
        }
        if control.tag == 1
        {
            // do something for control 1
        }
        if control.tag == 2
        {
            // do something for control 2
        }
        if control.tag == 3
        {
            // do something for control 3
        }
    }
 
    
    
}

