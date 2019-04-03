//
//  ViewController.swift
//  Havens Aero
//
//  Created by Daniel Dodson on 4/2/19.
//  Copyright © 2019 Daniel Dodson. All rights reserved.
//

import UIKit
import CoreData

class intialVC: UITableViewController {
    
    
    
    
    //MARK: Variables
    
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     var flightArray = [Flight]()
    
    
    
    
    //MARK: View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleModalDismissed), name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil)
        loadFlights()
    }
    
    
    
    
    //MARK: View did appear
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        loadFlights()
    }
    
    
    
    
    //MARK: objc to relaod data
    
    @objc func handleModalDismissed() {
        loadFlights()
        print("this should print something")
    }
    
    
    
    
    
    //MARK: tableview datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightArray.count
    }
    
    
    
    
    //MARK: TableView Cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "initialCell", for: indexPath)
        cell.textLabel?.text = flightArray[indexPath.row].tailNumber
        cell.textLabel?.textColor = UIColor.white
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        let dateString = formatter.string(from: flightArray[indexPath.row].flightDate!)
        cell.detailTextLabel?.text = dateString
        cell.detailTextLabel?.textColor = UIColor.white
        return cell
        
    }
    
    
    
    
    
    //MARK: tableview did select row at
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
    //MARK: add new item
    
    @IBAction func addNewClicked(_ sender: Any) {
        
       
    }
    
  
   
    
    
    //MARK: load Flights

    func loadFlights() {
        
        let request: NSFetchRequest<Flight> = Flight.fetchRequest()
        do {
        flightArray = try context.fetch(request)
        } catch {
            print ("error fetching context")
        }
        
        tableView.reloadData()
    }
    
    
   


}

