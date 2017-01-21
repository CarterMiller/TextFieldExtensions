# UITextFieldExtendedView
Extensions to UITextField in swift 3 - glowing edges, floating labels, pickerView and multi select

With a single class `UITextFieldExtendedView` you can have any combination of glowing edges, floating placeholders and popup pickerViews.

All of these controls are demonstrated in the example project.

## Usage
Copy the class files into your project
- UITextFieldExtendedView - global functions and variables
- UITextFieldExtendedViewFloat - extensions to support the floating placeholder text
- UITextFieldExtendedViewGlow - extensions to support glowing edges
- UITextFieldExtendedView - extensions to support popup pickerViews
- UITextFieldExtendedMultiPopup - extensions to support multi-selection.  Select from a dataset.

To use the controls, add a UITextField to a view, and change the class to UItextFieldExtendedView

You can then set which of the extended attributes you want, either in the storyboard or code.  By default, all options are set to false, and the control will operate as a UITextField.
- shouldDisplayPopup 
- shouldDisplayLabel
- shouldDisplayGlow

## TextFieldGlow
- shouldDisplayPopup    = false
- shouldDisplayLabel    = false
- shouldDisplayGlow     = true 

![Glowing](https://github.com/CarterMiller/TextFieldExtensions/blob/master/screenshots/Glowing.png)


## TextFieldFloatLabel
- shouldDisplayPopup    = false
- shouldDisplayLabel    = true
- shouldDisplayGlow     = true / false

![Floating Text](https://github.com/CarterMiller/TextFieldExtensions/blob/master/screenshots/Floating%20Text.png)

## TextFieldPopupView
- shouldDisplayPopup    = true
- shouldDisplayLabel    = true / false
- shouldDisplayGlow     = false

![Popup](https://github.com/CarterMiller/TextFieldExtensions/blob/master/screenshots/Popup.png)


- shouldDisplayPopup    = true
- shouldDisplayLabel    = true / false
- shouldDisplayGlow     = true

![Popup GLowing](https://github.com/CarterMiller/TextFieldExtensions/blob/master/screenshots/Popup%20Glowing.png)


- shouldDisplayPopup    = true
- shouldDisplayLabel    = true / false
- shouldDisplayGlow     = true
- define dataSet and also dataSetSelected


![MultiSelect](https://github.com/CarterMiller/TextFieldExtensions/blob/master/screenshots/MultiSelect.png)

### Initialisation
- By default, the control will display 5 lines in the popup view, but you can change that in Storyboard, or through code at any time.  You will not be able to display more than 12 lines, or fewer than 1.
- Each TextFieldPopupView control has an associated dataset, which defines the entries presented in the picker view
- You must set the Tag value of the control to a unique value, as this is used to identify each control

Initialise the text controls with their datasets - in viewDidLoad, or as required.  You can also add a tapGesture recogniser, so that you can hide the popup views when the user taps anywhere else on the screen.
```swift
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // set up the popup data.  You can do this at any time, and there are a range of overrides
        // Probably best to define everything in a single call as for textFieldPopup1
        textFieldPopup1.setup(dataSet: sampleData1, controlTag: 1,  delegate: self)
        textFieldPopup2.setup(dataSet: sampleData2, delegate: self)
        textFieldPopup2.tag = 2
        textFieldPopup3.setup(dataSet: sampleData3)
        textFieldPopup3.tag = 3
        textFieldPopup3.delegatePopup = self

        // the popup views will disappear when a value is selected
        // but to clear them when the user taps anywhere on the view, add this gesture recogniser
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        self.view.addGestureRecognizer(tapGestureBackground)    
    }

    func backgroundTapped(_ sender: UITapGestureRecognizer)
    {
        view.endEditingWithPopups(true)     // end editing for any UITextField controls, and also for standard controls
    }
```


The TextFieldPopupViewDelegate has to implement a single function to be informed of changes.  This function returns the Tag value of the text control, so that you can take any appropriate action.  If all that is required is to update the text field, then you don't need to do anything more in this function.

```swift
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

```
