# TextFieldExtensions
Extensions to UITextField in swift 3 - glowing edges, floating labels and pickerView

All of these controls are demonstrated in the example project.


## TextFieldGlow
Extension to UITextField which gives a glowing border when the control becomes firstResponder

## TextFieldFloatLabel
Extension to UITextField which includes a floating label which can be used as a placeholder, and also glowing border

## TextFieldPopupView
Extension to UITextField which gives popup picker view

### Initialisation

- Simply include the TextFieldPopupView.swift file in your project
- Add a UITextField to your view, and change the class to TextFieldPopupView
- By default, the control will display 5 lines in the popup view, but you can change that in Storyboard, or through code at any time.  You will not be able to display more than 12 lines, or fewer than 1.
- Each TextFieldPopupView control has an associated dataset, which defines the entries presented in the picker view
- You must set the Tag value of the control to a unique value, as this is used to identify each control

### Usage
------------------------------
Create outlets for your text controls, and create data sets
```swift
    @IBOutlet weak var textFieldPopup1: TextFieldPopupView!
    @IBOutlet weak var textFieldPopup2: TextFieldPopupView!
    @IBOutlet weak var textFieldPopup3: TextFieldPopupView!
    
    var sampleData1 = ["one", "two", "three", "four", "five"]
    var sampleData2 = ["cat", "dog", "mouse", "horse", "hamster", "snake"]
    var sampleData3 = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
 
```
In viewDidLoad, initialise the text controls with their datasets.  You can also add a tapGesture recogniser, so that you can hide the popup views when the user taps anywhere else on the screen.
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


The TextFieldPopupViewDelegate has to implement a single function to be informed of changes.  This function returns the Tag value of the text control, so that you can take any appropriate action 

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
