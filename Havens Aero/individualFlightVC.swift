//
//  individualFlightVC.swift
//  Havens Aero
//
//  Created by Daniel Dodson on 4/5/19.
//  Copyright © 2019 Daniel Dodson. All rights reserved.
//

import UIKit
import CoreData


class individualFlightVC: UITableViewController {
    
    
    
    
    //MARK: Variables
    
    
    var infoArray = [Info]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedFlight : Flight? {
        didSet {
            loadFlights()
            self.title = selectedFlight?.tailNumber
            print(selectedFlight)
        }
    }
   
    
    
    
    
    //MARK: Viewdidload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell")
        cell?.detailTextLabel?.textColor = UIColor.white
       
        
    }
    
    
    
    
    /*
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 0
    }
    
    */
    
    
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
    
    
    
    
    //MARK: save flight
    
    func saveFlight() {
        
        do {
            try context.save()
        } catch {
            print("error saving context")
        }
    }


    

}
