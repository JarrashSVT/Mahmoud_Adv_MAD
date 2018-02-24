//
//  DatabaseService.swift
//  CU Events v1.0
//
//  Created by Mahmoud Aljarrash on 2/24/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation
import Firebase

class DatabaseService
{
    static let shared = DatabaseService()
    private init() {}
    
    let eventsReference = Database.database().reference().child("events")
}
