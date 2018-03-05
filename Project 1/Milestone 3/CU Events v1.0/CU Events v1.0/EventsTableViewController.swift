//
//  EventsTableViewController.swift
//  CU Events v1.0
//
//  Created by Mahmoud Aljarrash on 2/23/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class EventsTableViewController: UITableViewController {

    
    var events = [Event]()
    
    @IBOutlet weak var addNewEventBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        getEvents()
        print(events)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if anyUserLoggedIn()
        {
            addNewEventBtn.isEnabled = true
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    @IBAction func unwingSegue(_ segue: UIStoryboardSegue)
    {
        print("EventsTableViewController -> unwingSegue()")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel!.text = events[indexPath.row].title
        cell.detailTextLabel!.text = events[indexPath.row].campus
        cell.imageView?.image = UIImage(named: "cu-logo-64")
        return cell
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "fromEventsTVCToEventDetailsSegue"
        {
            if let indexPath = tableView.indexPathForSelectedRow
            {
                let eventsVC = segue.destination as! EventDetailsViewController
                
                eventsVC.title = events[indexPath.row].title
                eventsVC.event = events[indexPath.row]
            }
        }
        
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
    
    func getEvents()
    {
        DatabaseService.shared.eventsReference.observe(.value, with: { snapshot in
            
            var events = [Event]()
            
            for e in snapshot.children.allObjects as! [DataSnapshot]
            {
                guard let value = e.value else {return}
                
                do
                {
                    let event = try FirebaseDecoder().decode(Event.self, from: value)
                    print(event)
                    events.append(event)
                }
                catch let error
                {
                    print(error)
                }
        
            }
            
            self.events = events
            self.tableView.reloadData()
        })
    }
    
    func anyUserLoggedIn() -> Bool
    {
        guard (Auth.auth().currentUser?.displayName) != nil
            else
        {
            return false
        }
        
        return true
    }
}
