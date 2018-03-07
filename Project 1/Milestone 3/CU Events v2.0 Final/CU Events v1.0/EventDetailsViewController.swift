//
//  EventDetailsViewController.swift
//  CU Events v1.0
//
//  Created by Mahmoud Aljarrash on 3/4/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit
import EventKit

class EventDetailsViewController: UIViewController {
    
    var event: Event?
    let store = EKEventStore()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var campusLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBAction func addToCalendarBtnTapped(_ sender: UIButton)
    {
        createCalendarEvent(event: self.event!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = event?.title
        descriptionLabel.text = event?.description
        campusLabel.text = event?.campus
        addressLabel.text = event?.address
        startDateLabel.text = event?.startDate
        endDateLabel.text = event?.endDate
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createCalendarEvent(event: Event)
    {
        store.requestAccess(to: .event) { (success, error) in
            guard error == nil else
            {
                print(error!.localizedDescription)
                AlertController.showAlert(inViewController: self, title: "Error: Calendar Events", message: error!.localizedDescription)
                return
            }
            
            let calendarEvent = EKEvent.init(eventStore: self.store)
            calendarEvent.title = event.title
            calendarEvent.calendar = self.store.defaultCalendarForNewEvents
            calendarEvent.startDate = self.getDateFromString(dateString: event.startDate)
            calendarEvent.endDate = self.getDateFromString(dateString: event.endDate)
            
            do
            {
                try self.store.save(calendarEvent, span: .thisEvent)
                print("Calendar event created successfully.")
                AlertController.showAlert(inViewController: self, title: "Event Added", message: "\(event.title) has been added successfully to your calendar")
            }
            catch let error
            {
                print(error.localizedDescription)
                AlertController.showAlert(inViewController: self, title: "Error: Calendar Events", message: error.localizedDescription)

            }
        }
    }
    
    func getDateFromString(dateString: String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        let date = dateFormatter.date(from: dateString)
        
        return date!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
