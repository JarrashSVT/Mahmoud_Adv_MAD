//
//  Event.swift
//  CU Events v1.0
//
//  Created by Mahmoud Aljarrash on 3/4/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation

struct Event: Decodable
{
    let title: String
    let description: String
    let campus: String
    let address: String
    let startDate: String
    let endDate: String
    
}
