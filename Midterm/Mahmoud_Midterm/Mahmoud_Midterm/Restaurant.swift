//
//  Restaurant.swift
//  Mahmoud_Midterm
//
//  Created by Mahmoud Aljarrash on 3/15/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation
import RealmSwift

class Restaurant: Object
{
    @objc dynamic var name = String()
    @objc dynamic var url = String()
    
    convenience init(name: String, url: String)
    {
        self.init()
        self.name = name
        self.url = url
    }
}
