//
//  ViewController.swift
//  Havens Aero
//
//  Created by Daniel Dodson on 4/2/19.
//  Copyright © 2019 Daniel Dodson. All rights reserved.
//

import UIKit
import CoreData

class intialVC: UITableViewController, UISearchBarDelegate {
    
    
    
    
    //MARK: Variables
    
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     var flightArray = [Flight]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
   
    
    
    
    //MARK: View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleModalDismissed), name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil)
        loadFlights()
        searchBarColor()
        
        
      
        
        
        
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
        cell.textLabel?.text = flightArray.reversed()[indexPath.row].tailNumber
        cell.textLabel?.textColor = UIColor.white
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        let dateString = formatter.string(from: flightArray.reversed()[indexPath.row].flightDate!)
        cell.detailTextLabel?.text = dateString
        cell.detailTextLabel?.textColor = UIColor.white
        return cell
        
    }
    
    
    
    
    //MARK: searchBar color
    
    func searchBarColor() {
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.white
            textfield.backgroundColor = UIColor.darkGray
        }
    }
    
    
    //MARK: delete trip
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
             self.context.delete(self.flightArray[indexPath.row])
            self.flightArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
            self.saveFlight()
        }
       // action.image = UIImage(named: "trashCan")
        action.backgroundColor = .red
     
        return action
    }
  
    
    
    
    
    
    //MARK: tableview did select row at
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    
    
    
    //MARK: add new item
    
    @IBAction func addNewClicked(_ sender: Any) {
        
       
    }
    
  
   
    
    
    //MARK: load Flights

    func loadFlights(with request: NSFetchRequest<Flight> = Flight.fetchRequest()) {
        
        do {
        flightArray = try context.fetch(request)
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
    
    
    
    
    //MARK: searh barsearch button clicked
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Flight> = Flight.fetchRequest()
         request.predicate = NSPredicate(format: "tailNumber CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "tailNumber", ascending: true)]
        
        loadFlights(with: request)
    }
    
    
    
    
    //MARK: search bar text did change
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadFlights()
            DispatchQueue.main.async {
                 searchBar.resignFirstResponder()
            }
        }
        else {
            let request: NSFetchRequest<Flight> = Flight.fetchRequest()
            request.predicate = NSPredicate(format: "tailNumber CONTAINS[cd] %@", searchBar.text!)
            request.sortDescriptors = [NSSortDescriptor(key: "tailNumber", ascending: true)]
            
            loadFlights(with: request)
        }
    }
    
    
   


}

