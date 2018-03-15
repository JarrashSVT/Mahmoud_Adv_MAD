//
//  MainTableViewController.swift
//  Mahmoud_Midterm
//
//  Created by Mahmoud Aljarrash on 3/15/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController {

    var restaurants: Results<Restaurant>?
    var filteredRestaurants = [Restaurant]()
    
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()

       let realm = RealmService.shared.realm
        restaurants = realm.objects(Restaurant.self)
        searchBarInit()
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if isFiltering()
        {
            return filteredRestaurants.count
        }
        
        return (restaurants?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let r: Restaurant  // restaurants![indexPath.row]
        
        if isFiltering()
        {
            r = filteredRestaurants[indexPath.row]
        }
        else
        {
            r = restaurants![indexPath.row]
        }
        
        cell.textLabel?.text = r.name
        
        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if isFiltering()
        {
            return false
        }
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            RealmService.shared.delete(restaurant: restaurants![indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSiteSegue"
        {
            print("preparing for showSiteSegue")
            
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                let showSiteVC = segue.destination as! ShowSiteViewController
                let r = restaurants![indexPath.row]

                showSiteVC.url = r.url
                
                
            }
        }
    }
    
    
    @IBAction func unwingSegue(_ segue: UIStoryboardSegue)
    {
        if segue.identifier == "saveSegue"
        {
            print("unwingSegue from saveSegue")
            
            let addVC = segue.source as! AddRestaurantViewController
            
            if addVC.addedRestaurant != nil
            {
            
                let newRestaurant = addVC.addedRestaurant
                RealmService.shared.save(restaurant: newRestaurant!)
                tableView.reloadData()
            }
        }
    }
    
    func searchBarInit()
    {
        // searchResultsUpdater is a property on UISearchController that conforms to the new protocol UISearchResultsUpdating.
        searchController.searchResultsUpdater = self
        // the current view will show the results
        searchController.obscuresBackgroundDuringPresentation = false
        //Set the placeholder
        searchController.searchBar.placeholder = "Search ..."
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        
        //        collectionView. = searchController.searchBar
        self.navigationItem.titleView = searchController.searchBar
        //setting definesPresentationContext on your view controller to true, you ensure that the search bar does not remain on the screen if the user navigates to another view controller while the UISearchController is active.
        definesPresentationContext = true
    }

}
