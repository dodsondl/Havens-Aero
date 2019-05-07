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
    
    
    @IBOutlet weak var label: UILabel!
    
  
    //MARK: Variables
    
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     var flightArray = [Flight]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
   
    
    
    
    //MARK: View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleModalDismissed), name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil)
        newLoad()
        //loadFlights()
        searchBarColor()
        
        
      self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
    }
    
    
    
    
    //MARK: View did appear
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        newLoad()
        //loadFlights()
    }
    
    
    
    
    //MARK: objc to relaod data
    
    @objc func handleModalDismissed() {
        newLoad()
        
        //loadFlights()
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
        tableView.reloadData()
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
             self.context.delete(self.flightArray[indexPath.row])
            self.flightArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
           
        }
      
        action.backgroundColor = .red
        self.saveFlight()
     
        return action
        
        
    }
  
    
    
    
    
    
    //MARK: tableview did select row at
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goToFlight", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        if segue.identifier == "goToFlight" {
        
        let destinationVC = segue.destination as! individualFlightVC
            
            
        if let indxPath = self.tableView.indexPathForSelectedRow {
            destinationVC.selectedFlight = flightArray[indxPath.row]
        }
        }
    }
    
    
    
    
    
    //MARK: add new item
    
    @IBAction func addNewClicked(_ sender: Any) {
        
       
    }
    
    
    
    //Reload Flights
    
    func newLoad() {
        
        let request = NSFetchRequest<Flight>(entityName: "Flight")
        let sort = NSSortDescriptor(key: #keyPath(Flight.flightDate), ascending: false)
        request.sortDescriptors = [sort]
        
        loadFlights(with: request)
        
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
            newLoad()
            //loadFlights()
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
    
    
    
    //MARK: quote button
    
    @IBAction func quoteButton(_ sender: Any) {
        
        guard let url = URL(string: "https://docs.google.com/spreadsheets/d/1-U5OWlOAzBBya1_mME5Ch3IJW1Zq0ZTHowpO3IDZGKw/edit#gid=1720220633") else { return }
        UIApplication.shared.open(url)
        
    }
    


}

