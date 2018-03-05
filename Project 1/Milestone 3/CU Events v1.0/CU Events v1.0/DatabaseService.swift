//
//  DatabaseService.swift
//  CU Events v1.0
//
//  Created by Mahmoud Aljarrash on 2/24/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

class DatabaseService
{
    static let shared = DatabaseService()
    private init() {}
    
    let eventsReference = Database.database().reference().child("events")
    
    
    // this function return empty array. required further troubleshooting 
    func getEvents() -> [Event]
    {
        var events = [Event]()
        
        self.eventsReference.observeSingleEvent(of: .value, with: { (snapshot) in
            
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
        })
    
        print("getEvents() -> ",events)
        return events
    }
}
