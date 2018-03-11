//
//  Vehicle.swift
//  Auto Sales
//
//  Created by Mahmoud Aljarrash on 2/16/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation
import RealmSwift

class Vehicle: Object
{
    @objc dynamic var bodyType = String()
    @objc dynamic var make = String()
    @objc dynamic var model = String()
    @objc dynamic var color = String()
    @objc dynamic var mileage = 0
    @objc dynamic var price = Float()
    @objc dynamic var year = String()
    
    
//    convenience init() {self.init()}
    
    convenience init(bodyType:String, make:String, model:String, year:String)
    {
        self.init()
        self.bodyType = bodyType
        self.make = make
        self.model = model
        self.year = year
    }
    
    convenience init(bodyType:String, make:String, model:String, year:String, color:String, price: Float, mileage: Int)
    {
        self.init()
        self.bodyType = bodyType
        self.make = make
        self.model = model
        self.year = year
        self.price = price
        self.mileage = mileage
        self.color = color
    }
    
    func toString() -> String
    {
        return self.bodyType + ";" + self.make + ";" + self.model + ";" + self.year + ";" + self.color + ";" + String(self.price) + ";" + String(self.mileage)
    }
}
