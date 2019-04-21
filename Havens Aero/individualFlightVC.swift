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
                textViewNotes.text = "Add Notes..."
                textViewNotes.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.hobbsIn != nil {
                hobbsIn.text = selectedFlight?.hobbsIn
                hobbsIn.textColor = UIColor.white
            } else {
                hobbsIn.text = "Add Time..."
                hobbsIn.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.hobbsOut != nil {
                hobbsOut.text = selectedFlight?.hobbsOut
                hobbsOut.textColor = UIColor.white
            } else {
                hobbsOut.text = "Add Time..."
                hobbsOut.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.tachIn != nil {
                tachIn.text = selectedFlight?.tachIn
                tachIn.textColor = UIColor.white
            } else {
                tachIn.text = "Add Time..."
                tachIn.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.tachOut != nil {
                tachOut.text = selectedFlight?.tachOut
                tachOut.textColor = UIColor.white
            } else {
                tachOut.text = "Add Time..."
                tachOut.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.oilStart != nil {
                oilStart.text = selectedFlight?.oilStart
                oilStart.textColor = UIColor.white
            } else {
                oilStart.text = "Add Oil..."
                oilStart.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.oilAdded != nil {
                oilAdded.text = selectedFlight?.oilAdded
                oilAdded.textColor = UIColor.white
            } else {
                oilAdded.text = "Add Oil..."
                oilAdded.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.fuelStart != nil {
                fuelStart.text = selectedFlight?.fuelStart
                fuelStart.textColor = UIColor.white
            } else {
                fuelStart.text = "Add Fuel..."
                fuelStart.textColor = UIColor.lightGray
            }
            
            if selectedFlight?.fuelAdded != nil {
                fuelAdded.text = selectedFlight?.fuelAdded
                fuelAdded.textColor = UIColor.white
            } else {
                fuelAdded.text = "Add Fuel..."
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
                textView.text = "Add Notes..."
                textView.textColor = UIColor.lightGray
                selectedFlight?.setValue(nil, forKey: "notes")
                self.saveFlight()
            
            }
            else {
               selectedFlight?.setValue(textViewNotes.text, forKey: "notes")
                self.saveFlight()
            }
            
        }
        
        if textView == hobbsIn {
            
            if textView.text.isEmpty {
                textView.text = "Add Time..."
                textView.textColor = UIColor.lightGray
                selectedFlight?.setValue(nil, forKey: "hobbsIn")
                self.saveFlight()
              
            }
            else {
                
                selectedFlight?.setValue(hobbsIn.text, forKey: "hobbsIn")
                self.saveFlight()
            }
            
        }
        
        if textView == hobbsOut {
            
            if textView.text.isEmpty {
                textView.text = "Add Time..."
                textView.textColor = UIColor.lightGray
                selectedFlight?.setValue(nil, forKey: "hobbsOut")
                self.saveFlight()
            }
            else {
                selectedFlight?.setValue(hobbsOut.text, forKey: "hobbsOut")
                self.saveFlight()
            }
            
        }
        
        if textView == tachIn {
            
            if textView.text.isEmpty {
                textView.text = "Add Time..."
                textView.textColor = UIColor.lightGray
                selectedFlight?.setValue(nil, forKey: "tachIn")
                self.saveFlight()
            }
            else {
                selectedFlight?.setValue(tachIn.text, forKey: "tachIn")
                self.saveFlight()
            }
            
        }
        
        if textView == tachOut {
            
            if textView.text.isEmpty {
                textView.text = "Add Time..."
                textView.textColor = UIColor.lightGray
                selectedFlight?.setValue(nil, forKey: "tachOut")
                self.saveFlight()
            }
            else {
                selectedFlight?.setValue(tachOut.text, forKey: "tachOut")
                self.saveFlight()
            }
            
        }
        
        if textView == oilStart {
            
            if textView.text.isEmpty {
                textView.text = "Add Oil..."
                textView.textColor = UIColor.lightGray
                selectedFlight?.setValue(nil, forKey: "oilStart")
                self.saveFlight()
            }
            else {
                selectedFlight?.setValue(oilStart.text, forKey: "oilStart")
                self.saveFlight()
            }
            
        }
        
        if textView == oilAdded {
            
            if textView.text.isEmpty {
                textView.text = "Add Oil..."
                textView.textColor = UIColor.lightGray
                selectedFlight?.setValue(nil, forKey: "oilAdded")
                self.saveFlight()
            }
            else {
                selectedFlight?.setValue(oilAdded.text, forKey: "oilAdded")
                self.saveFlight()
            }
            
        }
        
        if textView == fuelStart {
            
            if textView.text.isEmpty {
                textView.text = "Add Fuel..."
                textView.textColor = UIColor.lightGray
                selectedFlight?.setValue(nil, forKey: "fuelStart")
                self.saveFlight()
            }
            else {
                selectedFlight?.setValue(fuelStart.text, forKey: "fuelStart")
                self.saveFlight()
            }
            
        }
        
        if textView == fuelAdded {
            
            if textView.text.isEmpty {
                textView.text = "Add Fuel..."
                textView.textColor = UIColor.lightGray
                selectedFlight?.setValue(nil, forKey: "fuelAdded")
                self.saveFlight()
            }
            else {
                selectedFlight?.setValue(fuelAdded.text, forKey: "fuelAdded")
                self.saveFlight()
            }
            
        }
        
       
      
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.text.append("<br>")
        }
       return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "goToPDF" {
            
            let destinationVC = segue.destination as! previewPDF
            
            
           
                destinationVC.selectedFlight = selectedFlight
            
        }
    }
    
    
    //MARK: action sheet alert
    
    
    @IBAction func actionSheetAlert(_ sender: Any) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        let dateString = formatter.string(from: ((selectedFlight?.flightDate)!))
        
        var html = "<h1>Havens Aero</h1><b>\(selectedFlight?.customerName ?? "")</b> <br><b>\(selectedFlight?.tailNumber ?? "")</b><br><b>\(dateString)</b><br><br><br><b>Time</b><p>Hobbs In: <b>\(selectedFlight?.hobbsIn ?? "")</b></p><p>Hobbs Out: <b>\(selectedFlight?.hobbsOut ?? "")</b></p><p>Tach In: <b>\(selectedFlight?.tachIn ?? "")</b></p><p>Tach Out: <b>\(selectedFlight?.tachOut ?? "")</b></p><br><b>Fuel Levels</b><p>Oil Start: <b>\(selectedFlight?.oilStart ?? "")</b></p><p>Oil Added: <b>\(selectedFlight?.oilAdded ?? "")</b></p><p>Fuel Start: <b>\(selectedFlight?.fuelStart ?? "")</b></p><p>Fuel Added: <b>\(selectedFlight?.fuelAdded ?? "")</b></p><br><b>Notes</b><br><br><b>\(selectedFlight?.notes ?? "")</b>"
        let fmt = UIMarkupTextPrintFormatter(markupText: html)
        
        
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)
        
        
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        render.setValue(page, forKey: "paperRect")
        render.setValue(page, forKey: "printableRect")
        
         let pdfData = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        
        for i in 0..<render.numberOfPages {
            UIGraphicsBeginPDFPage();
            render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        
        UIGraphicsEndPDFContext();
        
        
        guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("output").appendingPathExtension("pdf")
            else { fatalError("Destination URL not created") }
        
        pdfData.write(to: outputURL, atomically: true)
        print("open \(outputURL.path)")
        
       // webView.loadHTMLString(html, baseURL: outputURL)
        let activityController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
       
        
    }
    
    

}
