//
//  individualFlightVC.swift
//  Havens Aero
//
//  Created by Daniel Dodson on 4/5/19.
//  Copyright © 2019 Daniel Dodson. All rights reserved.
//

import UIKit
import CoreData
import MessageUI


class individualFlightVC: UITableViewController, UITextViewDelegate {
    
    
    
    
    //MARK: Variables

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stepperNumber: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var textViewNotes: UITextView!
    @IBOutlet weak var hobbsIn: UITextView!
    @IBOutlet weak var hobbsOut: UITextView!
    @IBOutlet weak var tachIn: UITextView!
    @IBOutlet weak var tachOut: UITextView!
    @IBOutlet weak var oilStart: UITextView!
    @IBOutlet weak var oilAdded: UITextView!
    @IBOutlet weak var fuelStart: UITextView!
    @IBOutlet weak var fuelAdded: UITextView!
    
  
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedFlight : Flight? {
        didSet {
            
            tableView.reloadData()
            self.title = selectedFlight?.tailNumber
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
           let dateString = formatter.string(from: ((selectedFlight?.flightDate)!))
           self.dateLabel.text = dateString
            
            if selectedFlight?.notes != nil {
                textViewNotes.text = selectedFlight?.notes
                textViewNotes.textColor = UIColor.white
            } else {
                textViewNotes.text = "Notes..."
                textViewNotes.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.hobbsIn != nil {
                hobbsIn.text = selectedFlight?.hobbsIn
                hobbsIn.textColor = UIColor.white
            } else {
                hobbsIn.text = "In..."
                hobbsIn.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.hobbsOut != nil {
                hobbsOut.text = selectedFlight?.hobbsOut
                hobbsOut.textColor = UIColor.white
            } else {
                hobbsOut.text = "Out..."
                hobbsOut.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.tachIn != nil {
                tachIn.text = selectedFlight?.tachIn
                tachIn.textColor = UIColor.white
            } else {
                tachIn.text = "In..."
                tachIn.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.tachOut != nil {
                tachOut.text = selectedFlight?.tachOut
                tachOut.textColor = UIColor.white
            } else {
                tachOut.text = "Out..."
                tachOut.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.oilStart != nil {
                oilStart.text = selectedFlight?.oilStart
                oilStart.textColor = UIColor.white
            } else {
                oilStart.text = "Start..."
                oilStart.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.oilAdded != nil {
                oilAdded.text = selectedFlight?.oilAdded
                oilAdded.textColor = UIColor.white
            } else {
                oilAdded.text = "Added..."
                oilAdded.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.fuelStart != nil {
                fuelStart.text = selectedFlight?.fuelStart
                fuelStart.textColor = UIColor.white
            } else {
                fuelStart.text = "Start..."
                fuelStart.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.fuelAdded != nil {
                fuelAdded.text = selectedFlight?.fuelAdded
                fuelAdded.textColor = UIColor.white
            } else {
                fuelAdded.text = "Added..."
                fuelAdded.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.stepperNumber != nil {
                stepperNumber.text = selectedFlight?.stepperNumber
            } else {
              stepperNumber.text = "0"
            }
            
            
         
        }
    }
   
    override func viewDidDisappear(_ animated: Bool) {
        
      
        
    }
    
    
    
    //MARK: Viewdidload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.maximumValue = 9
       tableView.keyboardDismissMode = .onDrag
    
    txtViewDesign()
    }
    
    
    
    
    
    //MARK: textView design
    
    func txtViewDesign() {
        
        
      
        
        textViewNotes.text = "Notes..."
        textViewNotes.textColor = UIColor.lightGray
        textViewNotes.delegate = self
        hobbsIn.text = "In..."
        hobbsIn.textColor = UIColor.lightGray
        hobbsIn.delegate = self
        hobbsOut.text = "Out..."
        hobbsOut.textColor = UIColor.lightGray
        hobbsOut.delegate = self
        tachIn.text = "In..."
        tachIn.textColor = UIColor.lightGray
        tachIn.delegate = self
        tachOut.text = "Out..."
        tachOut.textColor = UIColor.lightGray
        tachOut.delegate = self
        oilStart.text = "Start..."
        oilStart.textColor = UIColor.lightGray
        oilStart.delegate = self
        oilAdded.text = "Added..."
        oilAdded.textColor = UIColor.lightGray
        oilAdded.delegate = self
        fuelStart.text = "Start..."
        fuelStart.textColor = UIColor.lightGray
        fuelStart.delegate = self
        fuelAdded.text = "Added..."
        fuelAdded.textColor = UIColor.lightGray
        fuelAdded.delegate = self
 
        
    }
    
    
    
    /*
    
    //MARK: load Flights
    
    func loadFlights(with request: NSFetchRequest<Info> = Info.fetchRequest()) {
        
        let predicate = NSPredicate(format: "parentCategory.tailNumber MATCHES %@", selectedFlight!.tailNumber!)
        
        request.predicate = predicate
        
        do {
            infoArray = try context.fetch(request)
        } catch {
            print ("error fetching context")
        }
        
        tableView.reloadData()
    }
    
    */
    
    
    //MARK: save flight
    
    func saveFlight() {
        
        do {
            try context.save()
        } catch {
            print("error saving context")
        }
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        stepperNumber.text = Int(sender.value).description
        selectedFlight?.setValue(Int(sender.value).description, forKey: "stepperNumber")
        saveFlight()
        
    }
    
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView == textViewNotes {
            
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.white
            }
            
        }
        
        if textView == hobbsIn {
            
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.white
            }
            
        }
        
        if textView == hobbsOut {
            
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.white
            }
            
        }
        
        if textView == tachIn {
            
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.white
            }
            
        }
        
        if textView == tachOut {
            
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.white
            }
            
        }
        
        if textView == oilStart {
            
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.white
            }
            
        }
        
        if textView == oilAdded {
            
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.white
            }
            
        }
        
        if textView == fuelStart {
            
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.white
            }
            
        }
        
        if textView == fuelAdded {
            
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.white
            }
            
        }
       
    }
    
    
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView == textViewNotes {
            
            if textView.text.isEmpty {
                textView.text = "Notes..."
                textView.textColor = UIColor.lightGray
            }
            else {
               selectedFlight?.setValue(textViewNotes.text, forKey: "notes")
                self.saveFlight()
            }
            
        }
        
        if textView == hobbsIn {
            
            if textView.text.isEmpty {
                textView.text = "In..."
                textView.textColor = UIColor.lightGray
            }
            else {
                selectedFlight?.setValue(hobbsIn.text, forKey: "hobbsIn")
                self.saveFlight()
            }
            
        }
        
        if textView == hobbsOut {
            
            if textView.text.isEmpty {
                textView.text = "Out..."
                textView.textColor = UIColor.lightGray
            }
            else {
                selectedFlight?.setValue(hobbsOut.text, forKey: "hobbsOut")
                self.saveFlight()
            }
            
        }
        
        if textView == tachIn {
            
            if textView.text.isEmpty {
                textView.text = "In..."
                textView.textColor = UIColor.lightGray
            }
            else {
                selectedFlight?.setValue(tachIn.text, forKey: "tachIn")
                self.saveFlight()
            }
            
        }
        
        if textView == tachOut {
            
            if textView.text.isEmpty {
                textView.text = "Out..."
                textView.textColor = UIColor.lightGray
            }
            else {
                selectedFlight?.setValue(tachOut.text, forKey: "tachOut")
                self.saveFlight()
            }
            
        }
        
        if textView == oilStart {
            
            if textView.text.isEmpty {
                textView.text = "Start..."
                textView.textColor = UIColor.lightGray
            }
            else {
                selectedFlight?.setValue(oilStart.text, forKey: "oilStart")
                self.saveFlight()
            }
            
        }
        
        if textView == oilAdded {
            
            if textView.text.isEmpty {
                textView.text = "Added..."
                textView.textColor = UIColor.lightGray
            }
            else {
                selectedFlight?.setValue(oilAdded.text, forKey: "oilAdded")
                self.saveFlight()
            }
            
        }
        
        if textView == fuelStart {
            
            if textView.text.isEmpty {
                textView.text = "Start..."
                textView.textColor = UIColor.lightGray
            }
            else {
                selectedFlight?.setValue(fuelStart.text, forKey: "fuelStart")
                self.saveFlight()
            }
            
        }
        
        if textView == fuelAdded {
            
            if textView.text.isEmpty {
                textView.text = "Added..."
                textView.textColor = UIColor.lightGray
            }
            else {
                selectedFlight?.setValue(fuelAdded.text, forKey: "fuelAdded")
                self.saveFlight()
            }
            
        }
        
       
      
    }
    
    
    
    
    //MARK: action sheet alert
    
    
    @IBAction func actionSheetAlert(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        UIVisualEffectView.appearance(whenContainedInInstancesOf: [UIAlertController.classForCoder() as! UIAppearanceContainer.Type]).effect = UIBlurEffect(style: .dark)
        actionSheet.view.tintColor = UIColor.white
        let savePDF = UIAlertAction(title: "Save PDF", style: .default) { (action) in
            
        }
        let emailPDF = UIAlertAction(title: "Email PDF", style: .default) { (action) in
            
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(cancel)
        actionSheet.addAction(savePDF)
        actionSheet.addAction(emailPDF)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    

}
