//
//  popUpVC.swift
//  Havens Aero
//
//  Created by Daniel Dodson on 4/2/19.
//  Copyright © 2019 Daniel Dodson. All rights reserved.
//

import UIKit
import CoreData

class popUpVC: UIViewController {
    
    
    
    //MARK: Variables
    
    @IBOutlet weak var topColorView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var popUpButton: UIButton!
    @IBOutlet weak var flightDateTextField: UITextField!
    @IBOutlet weak var tailNumberTextField: UITextField!
    var datePicker = UIDatePicker()
    var flightArray = [Flight]()
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   
    
    
    //MARK: view did laod
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius = 8
        popUpButton.layer.cornerRadius = 8
        topColorView.layer.cornerRadius = 8
        topColorView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        datePicker.datePickerMode = .date
        createDatePicker()
    }
    
    
    
    
    //MARK: popup button clicked

    @IBAction func popUpButtonClicked(_ sender: Any) {
        
        let newFlight = Flight(context: context)
        newFlight.tailNumber = tailNumberTextField.text!
        newFlight.flightDate = datePicker.date
        self.flightArray.append(newFlight)
        self.saveFlight()
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil)
        }
    }
    
    
    
    
    //MARK: exit button clicked
    
    @IBAction func exitPopUpButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK: createDate picker
    
    func createDatePicker () {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneSelector))
        toolbar.setItems([done], animated: false)
        
        flightDateTextField.inputAccessoryView = toolbar
        flightDateTextField.inputView = datePicker
        flightDateTextField.keyboardAppearance = UIKeyboardAppearance.dark
    }
    
    
    
    //MARK: objc for done selector
    
    @objc func doneSelector() {
    
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyy"
        
        let dateString = formatter.string(from: datePicker.date)
        
        
        flightDateTextField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    
    
    
    //MARK: save flight
    
    func saveFlight() {
        
        do {
            try context.save()
        } catch {
            print("error saving context")
        }
        
        
    }
    
    

}
