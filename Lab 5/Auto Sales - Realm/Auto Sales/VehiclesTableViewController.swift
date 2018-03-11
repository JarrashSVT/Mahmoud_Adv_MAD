//
//  VehiclesTableViewController.swift
//  Auto Sales
//
//  Created by Mahmoud Aljarrash on 2/16/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit
import RealmSwift

class VehiclesTableViewController: UITableViewController {

    
    var bodyStyle: String = ""

    var vehicles: Results<Vehicle>!
    var fvehicles = [Vehicle]() // filtered inventory
    
    var filteredVehicles = [Vehicle]() // filtered search result
    
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewWillAppear(_ animated: Bool)
    {
        print("Welcome to VehiclesTableViewController -> viewWillAppear()")
        
        let realm = RealmService.share.realm
        vehicles = realm.objects(Vehicle.self)
        tableView.reloadData()
        filterInventoryByBodyStyle()
        for v in vehicles
        {
            print(v.model)
        }
    }
    
    func filterInventoryByBodyStyle()
    {
        print("filterInventoryByBodyStyle()")
        fvehicles = [Vehicle]()
        for v in self.vehicles
        {
            if String(v.bodyType) == bodyStyle
            {
                print("adding \(v.make) \(v.model) to the filtered list (fvehicles) ")
                fvehicles.append(v)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        print("Welcome to VehiclesTableViewController -> viewDidLoad()")
        print("user chose ", bodyStyle)
        //getVehicles()
        
        // searchResultsUpdater is a property on UISearchController that conforms to the new protocol UISearchResultsUpdating.
        searchController.searchResultsUpdater = self
        // the current view will show the results
        searchController.obscuresBackgroundDuringPresentation = false
        //Set the placeholder
        searchController.searchBar.placeholder = "Search a Maker or a Model or a Year"
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        
        //navigationItem.searchController = searchController
        tableView.tableHeaderView = searchController.searchBar
        //setting definesPresentationContext on your view controller to true, you ensure that the search bar does not remain on the screen if the user navigates to another view controller while the UISearchController is active.
        definesPresentationContext = true
        
    }

    @IBAction func unwingSegue(_ segue: UIStoryboardSegue)
    {
        if segue.identifier == "saveSegue"
        {
            print("Entered saveSegue")
            let newVehicleVC = segue.source as! NewVehicleViewController
            
            if newVehicleVC.newVehicle.make != ""
            {
                let newAddedVehicle = newVehicleVC.newVehicle
                RealmService.share.save(vehicle: newAddedVehicle)

                print("Reloading the table view")
                self.viewWillAppear(true)

            
            }
            else
            {
//                AlertController.showAlert(inViewController: self, title: "Missing Info", message: "Please try again and fill ALL fields")
                print("unwingSegue() -> fvehicles.count ",fvehicles.count)
            }
        
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isFiltering()
        {
            return filteredVehicles.count
        }
        return fvehicles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let v : Vehicle
        
        if isFiltering()
        {
            v = filteredVehicles[indexPath.row]
        }
        else
        {
            v = fvehicles[indexPath.row]
            print("fvehicles size is ", fvehicles.count)
        }
        
        print("index path = ", indexPath.row)
        
        
        cell.textLabel?.text = v.make + " " + v.model + " " + v.year
        
        cell.detailTextLabel?.text = String(v.price)
        
        //cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let vehicleToDelete = fvehicles[indexPath.row]

            fvehicles.remove(at: indexPath.row)
            RealmService.share.delete(vehicle: vehicleToDelete)

            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert
        {
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toVehicleInfoTVC"
        {
            
            let vehicleInfoTVC = segue.destination as! VehicleInfoTableViewController
            // get the index for tapped cell
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            print("indexPath = ", indexPath.row)
            
            print("make =", fvehicles[indexPath.row].make)
            print("model =", fvehicles[indexPath.row].model)
            vehicleInfoTVC.make = fvehicles[indexPath.row].make
            vehicleInfoTVC.model = fvehicles[indexPath.row].model
            vehicleInfoTVC.color = fvehicles[indexPath.row].color
            vehicleInfoTVC.bodyStyle = fvehicles[indexPath.row].bodyType
            vehicleInfoTVC.price = String(fvehicles[indexPath.row].price)
            vehicleInfoTVC.mileage = String(fvehicles[indexPath.row].mileage)
            vehicleInfoTVC.year = fvehicles[indexPath.row].year
        }
        else if segue.identifier == "toAddNewVehicleVCSegue"
        {
            let destinationNavigationController = segue.destination as! UINavigationController
            let newVehicleVC = destinationNavigationController.topViewController as! NewVehicleViewController
            
            newVehicleVC.bodyStyle = self.title!
        }
        
    }
    
    func searchBarIsEmpty() -> Bool
    {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All")
    {
        filteredVehicles = fvehicles.filter({ (v : Vehicle) -> Bool in
            return v.make.lowercased().contains(searchText.lowercased())
                || v.model.lowercased().contains(searchText.lowercased())
                || v.year.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool
    {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension VehiclesTableViewController : UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        searchController.searchResultsController?.view.isHidden = false
        filterContentForSearchText(searchController.searchBar.text!)
    }
    

}
