//
//  API.swift
//  petitions
//
//  Created by Mahmoud Aljarrash on 2/23/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation

struct API: Decodable {
    //let metadata: [String: String]
    let results : [Petition]
}
