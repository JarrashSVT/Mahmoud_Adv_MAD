//
//  ViewController.swift
//  Auto Sales
//
//  Created by Mahmoud Aljarrash on 2/16/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    var cars = [String]()
    var bodyStyles = ["Coupe", "SUV", "Convertible", "Sedan", "Wagon"]
    var inventory = VehiclesInventory()
    let kfilename = "data16.plist"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return bodyStyles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = bodyStyles[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("prepare for segue ...")

        if segue.identifier == "toVehiclesTableVcSegue"
        {
            print("toVehiclesTableVcSegue")
            // get the index for tapped cell
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            print("indexPath = ", indexPath.row)
            
            let vehiclesVC = segue.destination as! VehiclesTableViewController
            
            vehiclesVC.bodyStyle = bodyStyles[indexPath.row]
            vehiclesVC.title = bodyStyles[indexPath.row]
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}

