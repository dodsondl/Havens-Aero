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
    
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var popUpButton: UIButton!
    @IBOutlet weak var flightDateTextField: UITextField!
    @IBOutlet weak var tailNumberTextField: UITextField!
    var datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
popUpView.layer.cornerRadius = 8
        popUpButton.layer.cornerRadius = 8
     
        datePicker.datePickerMode = .date
     
        
        createDatePicker()
        
    }

    @IBAction func popUpButtonClicked(_ sender: Any) {
    }
    
    func createDatePicker () {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneSelector))
        toolbar.setItems([done], animated: false)
        
        flightDateTextField.inputAccessoryView = toolbar
        flightDateTextField.inputView = datePicker
    }
    
    @objc func doneSelector() {
        
        //date format
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyy"
       
        let dateString = formatter.string(from: datePicker.date)
        
        
        flightDateTextField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
}
