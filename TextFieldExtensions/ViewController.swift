//
//  ViewController.swift
//  TextFieldPopupView
//
//  Created by Russell Morgan on 16/01/2017.
//  Copyright © 2017 Carter Miller. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate, TextFieldPopupViewDelegate, URLSessionDataDelegate
{

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: TextFieldPopupView!
    @IBOutlet weak var textField3: TextFieldPopupView!
    @IBOutlet weak var textField4: TextFieldFloatLabel!
    @IBOutlet weak var textField5: TextFieldGlow!
       
    var sampleData1 = ["one", "two", "three", "four", "five"]
    var sampleData2 = ["cat", "dog", "mouse", "horse", "hamster", "snake"]
    var sampleData3 = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // set up the popup data.  You can do this at any time
        textField2.setup(dataSet: sampleData2, controlTag: 2,  delegate: self)
        textField3.setup(dataSet: sampleData3, controlTag: 3,  delegate: self)

        // the popup views will disappear when a value is selected
        // but to clear them when the user taps anywhere on the view, add this gesture recogniser
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        self.view.addGestureRecognizer(tapGestureBackground)
        
    }
    
    func backgroundTapped(_ sender: UITapGestureRecognizer)
    {
        view.endEditingWithPopups(true)       // end editing for any UITextField controls, and also for standard controls
    }

    // TextFieldPopupViewDelegate
    func popupPickerViewChanged(valueReturn : String, controlTag : Int, valueChanged : Bool)
    {
        if valueChanged == false
        {
            return
        }
        
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

