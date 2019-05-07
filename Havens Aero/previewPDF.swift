//
//  previewPDF.swift
//  Havens Aero
//
//  Created by Daniel Dodson on 4/18/19.
//  Copyright © 2019 Daniel Dodson. All rights reserved.
//

import UIKit
import MessageUI



class previewPDF: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    var selectedFlight : Flight? {
        
        didSet{
        //self.title = selectedFlight?.tailNumber
            
            tailNumber = selectedFlight?.tailNumber ?? ""
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            dateString = formatter.string(from: ((selectedFlight?.flightDate)!))
            hobbsIn = selectedFlight?.hobbsIn ?? ""
            hobbsOut = selectedFlight?.hobbsOut ?? ""
            tachIn = selectedFlight?.tachIn ?? ""
            tachOut = selectedFlight?.tachOut ?? ""
            oilStart = selectedFlight?.oilStart ?? ""
            oilAdded = selectedFlight?.oilAdded ?? ""
            fuelStart = selectedFlight?.fuelStart ?? ""
            fuelAdded = selectedFlight?.fuelAdded ?? ""
            notes = selectedFlight?.notes ?? ""
            customerName = selectedFlight?.customerName ?? ""
        }
    }

  
    @IBOutlet weak var webView: UIWebView!
    
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
   
    
   var tailNumber = ""
    var dateString = ""
    var hobbsIn = ""
    var hobbsOut = ""
    var tachIn = ""
    var tachOut = ""
    var oilStart = ""
    var oilAdded = ""
    var fuelStart = ""
    var fuelAdded = ""
    var notes = ""
    var customerName = ""
    
    var html = ""
    
     let pdfData = NSMutableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        
       
        html = "<h1>Havens Aero</h1><b>\(customerName)</b> <br><b>\(tailNumber)</b><br><b>\(dateString)</b><br><br><br><b>Time</b><p>Hobbs In: <b>\(hobbsIn)</b></p><p>Hobbs Out: <b>\(hobbsOut)</b></p><p>Tach In: <b>\(tachIn)</b></p><p>Tach Out: <b>\(tachOut)</b></p><br><b>Fuel Levels</b><p>Oil Start: <b>\(oilStart)</b></p><p>Oil Added: <b>\(oilAdded)</b></p><p>Fuel Start: <b>\(fuelStart)</b></p><p>Fuel Added: <b>\(fuelAdded)</b></p><br><b>Notes</b><br><br><b>\(notes)</b>"
        let fmt = UIMarkupTextPrintFormatter(markupText: html)
        
       
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)
        
 
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        render.setValue(page, forKey: "paperRect")
        render.setValue(page, forKey: "printableRect")
    
        
       
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
        
        webView.loadHTMLString(html, baseURL: outputURL)



    }
    
    
    @IBAction func exportPDFClicked(_ sender: Any) {
        
        
        /*
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setSubject("\(dateString) Squawk List")
        composer.setMessageBody(html, isHTML: true)
        present(composer, animated: true, completion: nil)
        */
        
        let activityController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
 
    

}
