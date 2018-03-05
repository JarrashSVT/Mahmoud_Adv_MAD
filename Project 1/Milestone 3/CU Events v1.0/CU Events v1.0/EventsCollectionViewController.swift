//
//  EventsCollectionViewController.swift
//  CU Events v1.0
//
//  Created by Mahmoud Aljarrash on 3/4/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit
import CodableFirebase
import Firebase

private let reuseIdentifier = "cell"

class EventsCollectionViewController: UICollectionViewController {

    var events = [Event]()
    var selectedEvent: Event?
    
    @IBOutlet weak var addNewEventBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        getEvents()
        print(events)
        print("# of events: ",events.count)
        
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumLineSpacing = 1


        // Register cell classes
        // EVIL LINE :(
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)


    }

    override func viewWillAppear(_ animated: Bool) {
        if anyUserLoggedIn()
        {
            addNewEventBtn.isEnabled = true
        }
        else
        {
            addNewEventBtn.isEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    // MARK: - Navigation

     @IBAction func unwingSegue(_ segue: UIStoryboardSegue)
     {
     print("EventsTableViewController -> unwingSegue()")
     }
     /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return events.count
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return events.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EventsCollectionViewCell
    
        // Configure the cell
        let event = events[indexPath.row]
        cell.title.text = event.title
        cell.campus.text = event.campus
        cell.startDate.text = "Starting \(event.startDate)" 
        
        let eventImgUrl = event.image
        let url = URL(string: eventImgUrl)
        let session = URLSession.shared.dataTask(with: url!) { (date, response, error) in
            
            guard error == nil else
            {
                print(error!.localizedDescription)
                return
            }
            
            // Download image successful
            DispatchQueue.main.async {
                cell.img.image = UIImage(data: date!)
            }
            
        }
        session.resume()
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedEvent = events[indexPath.row]
        
        performSegue(withIdentifier: "fromEventCVCToEventDetailsVCSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromEventCVCToEventDetailsVCSegue"
        {

            let eventsVC = segue.destination as! EventDetailsViewController
            print("selected event : ", selectedEvent!)
            eventsVC.title = selectedEvent?.title
            eventsVC.event = selectedEvent

        }
    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
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
            self.collectionView?.reloadData()
//            self.tableView.reloadData()
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
