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
    
    
    
    
    
    let itemArray = ["one", "two", "three", "four"]
    let itemArrayz = ["1","2","3","4"]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    
    
    
    //MARK: tableview datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArrayz.count
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "initialCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.text = itemArrayz[indexPath.row]
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
    
    
   


}

