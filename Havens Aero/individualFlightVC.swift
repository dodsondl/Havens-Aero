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
    @IBOutlet weak var textViewNotes: UITextView!
    @IBOutlet weak var hobbsIn: UITextView!
    @IBOutlet weak var hobbsOut: UITextView!
    @IBOutlet weak var tachIn: UITextView!
    @IBOutlet weak var tachOut: UITextView!
    @IBOutlet weak var oilStart: UITextView!
    @IBOutlet weak var oilAdded: UITextView!
    @IBOutlet weak var fuelStart: UITextView!
    @IBOutlet weak var fuelAdded: UITextView!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var departView: UITextView!
    @IBOutlet weak var arriveView: UITextView!
    
    
  
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedFlight : Flight? {
        didSet {
            
            tableView.reloadData()
            self.title = selectedFlight?.tailNumber
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
           let dateString = formatter.string(from: ((selectedFlight?.flightDate)!))
           self.dateLabel.text = dateString
            self.customerNameLabel.text = selectedFlight?.customerName
            
            
            
            introFlight(textViewNotes, selectFlight: (selectedFlight?.notes)!, notes: "Add Notes...")
            introFlight(hobbsIn, selectFlight: (selectedFlight?.hobbsIn)!, notes: "Add Time...")
            introFlight(hobbsOut, selectFlight: (selectedFlight?.hobbsOut)!, notes: "Add Time...")
            introFlight(tachIn, selectFlight: (selectedFlight?.tachIn)!, notes: "Add Time...")
            introFlight(tachOut, selectFlight: (selectedFlight?.tachOut)!, notes: "Add Time...")
            introFlight(oilStart, selectFlight: (selectedFlight?.oilStart)!, notes: "Add Oil...")
            introFlight(oilAdded, selectFlight: (selectedFlight?.oilAdded)!, notes: "Add Oil...")
            introFlight(fuelStart, selectFlight: (selectedFlight?.fuelStart)!, notes: "Add Fuel...")
            introFlight(fuelAdded, selectFlight: (selectedFlight?.fuelAdded)!, notes: "Add Fuel...")
            introFlight(departView, selectFlight: (selectedFlight?.depart)!, notes: "Depart...")
            introFlight(arriveView, selectFlight: (selectedFlight?.arrive)!, notes: "Arrive...")
            
         
        }
    }
    
    func introFlight(_ textView: UITextView, selectFlight: String, notes: String) {
        
        if selectFlight != nil {
            textView.text = selectFlight
            textView.textColor = UIColor.white
        }
        else {
            textView.text = notes
            textView.textColor = UIColor.lightGray
        }
        
    }
   
    override func viewDidDisappear(_ animated: Bool) {
        
      
        
    }
    
    
    override func viewDidLayoutSubviews() {
        
       // textViewNotes.centerVertically()
        hobbsIn.centerVertically()
        hobbsOut.centerVertically()
        tachIn.centerVertically()
        tachOut.centerVertically()
        oilStart.centerVertically()
        oilAdded.centerVertically()
        fuelStart.centerVertically()
        fuelAdded.centerVertically()
        departView.centerVertically()
        arriveView.centerVertically()

        
    }
    
    
    
    //MARK: Viewdidload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
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
        departView.text = "Add city..."
        departView.textColor = UIColor.lightGray
        departView.delegate = self
        arriveView.text = "Add city..."
        arriveView.textColor = UIColor.lightGray
        arriveView.delegate = self
 
        
    }
    

    
    
    
    //MARK: save flight
    
    
    func saveFlight() {
        
        do {
            try context.save()
        } catch {
            print("error saving context")
        }
    }

    

    
    //text design for textViewDidBeginEditing
    
    func textDesign(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    
    
    
    //Call Viewdidbegin editing
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView == textViewNotes {
        textDesign(textViewNotes)
        }
        if textView == hobbsIn {
        textDesign(hobbsIn)
        }
        if textView == hobbsOut {
        textDesign(hobbsOut)
        }
        if textView == tachIn {
        textDesign(tachIn)
        }
        if textView == tachOut {
        textDesign(tachOut)
        }
        if textView == oilStart {
        textDesign(oilStart)
        }
        if textView == oilAdded {
        textDesign(oilAdded)
        }
        if textView == fuelStart {
        textDesign(fuelStart)
        }
        if textView == fuelAdded {
        textDesign(fuelAdded)
        }
        if textView == departView {
        textDesign(departView)
        }
        if textView == arriveView {
        textDesign(arriveView)
        }
        
       
    }
    
    //view did end editing
    
    func endEdit(_ textView: UITextView, notes: String, forKey: String) {
        
        if textView.text.isEmpty {
            textView.text = notes
            textView.textColor = UIColor.lightGray
            selectedFlight?.setValue(nil, forKey: forKey)
            self.saveFlight()
            
        }
        else {
            selectedFlight?.setValue(textViewNotes.text, forKey: forKey)
            self.saveFlight()
        }
        
    }
    
    
    
    
    // Call View Did end editing
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        
        if textView == textViewNotes {
        endEdit(textView, notes: "Add Notes...", forKey: "notes")
        }
        if textView == hobbsIn {
        endEdit(textView, notes: "Add Time...", forKey: "hobbsIn")
        }
        if textView == hobbsOut {
        endEdit(textView, notes: "Add Time...", forKey: "hobbsOut")
        }
        if textView == tachIn {
        endEdit(textView, notes: "Add Time...", forKey: "tachIn")
        }
        if textView == tachOut {
        endEdit(textView, notes: "Add Time...", forKey: "tachOut")
        }
        if textView == oilStart {
        endEdit(textView, notes: "Add Oil...", forKey: "oilStart")
        }
        if textView == oilAdded {
        endEdit(textView, notes: "Add Oil...", forKey: "oilAdded")
        }
        if textView == fuelStart {
        endEdit(textView, notes: "Add Fuel...", forKey: "fuelStart")
        }
        if textView == fuelAdded {
        endEdit(textView, notes: "Add Fuel", forKey: "fuelAdded")
        }
        if textView == departView {
        endEdit(textView, notes: "Add City...", forKey: "depart")
        }
        if textView == arriveView {
        endEdit(textView, notes: "Add City...", forKey: "arrive")
        }
       
      
    }
    
    
    //Segue to PDF
    
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
        let not = selectedFlight?.notes ?? ""
        let newNot = not.replacingOccurrences(of: "\n", with: "<br>")
        
        let html = "<html><head><style>.invoice-box {max-width: 800px;margin: auto; padding: 30px; border: 1px solid #eee; box-shadow: 0 0 10px rgba(0, 0, 0, .15); font-size: 16px; line-height: 24px; font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif; color: #555;} h1 {font-size: 45px; font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif; color: #555;} .invoice-box table {width: 100%; line-height: inherit; text-align: left;} .invoice-box table td {padding: 5px; vertical-align: top;} .invoice-box table tr td:nth-child(2) {text-align: right;} .invoice-box table tr.top table td {padding-bottom: 20px;} .invoice-box table tr.top table td.title {font-size: 45px; line-height: 45px; color: #333;} .invoice-box table tr.information table td {padding-bottom: 40px;}.invoice-box table tr.heading td {background: #eee;border-bottom: 1px solid #ddd;font-weight: bold;}.invoice-box table tr.details td {padding-bottom: 20px;}.invoice-box table tr.item td{border-bottom: 1px solid #eee;}.invoice-box table tr.item.last td {border-bottom: none;}.invoice-box table tr.total td:nth-child(2) {border-top: 2px solid #eee;font-weight: bold;}@media only screen and (max-width: 600px) {.invoice-box table tr.top table td {width: 100%; display: block;text-align: center;}.invoice-box table tr.information table td {width: 100%;display: block;text-align: center;}}.rtl {direction: rtl;font-family: Tahoma, 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;} .rtl table {text-align: right;}.rtl table tr td:nth-child(2) {text-align: left;}</style></head><body><div class='invoice-box'><table cellpadding='0' cellspacing='0'><tr class='top'><td colspan='2'><table><tr><td class='title'><h1>Havens Aero</h1></td><td></td></tr></table></td></tr><tr class='information'><td colspan='2'><table><tr><td>Havens Aero<br>401 Scarlet Oak Drive<br>Findlay, OH 45840</td><td>Customer Name: \(selectedFlight?.customerName ?? "")<br>Tail Number: \(selectedFlight?.tailNumber ?? "")<br>Flight Date: \(dateString)<br> Departure: \(selectedFlight?.depart ?? "")<br>Arrival: \(selectedFlight?.arrive ?? "")</td></tr></table></td></tr><tr class='heading'><td>Time</td><td></td></tr><tr class='item'><td>Hobbs In:</td><td>\(selectedFlight?.hobbsIn ?? "")</td></tr><tr class='item'><td>Hobbs Out:</td><td>\(selectedFlight?.hobbsOut ?? "")</td></tr><tr class='item'><td>Tach In:</td><td>\(selectedFlight?.tachIn ?? "")</td></tr><tr class='item'><td>Tach Out:</td><td>\(selectedFlight?.tachOut ?? "")</td></tr><tr class='heading'><td>Fuel Levels</td><td></td></tr><tr class='item'><td>Oil Start</td><td>\(selectedFlight?.oilStart ?? "") qts</td></tr><tr class='item'><td>Oil Added</td><td>\(selectedFlight?.oilAdded ?? "") qts</td></tr><tr class='item'><td>Fuel Start</td><td>\(selectedFlight?.fuelStart ?? "") GAL</td></tr><tr class='item'><td>Fuel Added</td><td>\(selectedFlight?.fuelAdded ?? "") GAL</td></tr><tr class='heading'><td>Notes</td><td></td></tr><tr class='item'><td>\(newNot)</td><td></td></tr></table></div></body></html>"
        let fmt = UIMarkupTextPrintFormatter(markupText: html)
        
        
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)
        
        
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) 
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
        
   
        let activityController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
       
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    


}


//Center the text in the middle of cell

extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
