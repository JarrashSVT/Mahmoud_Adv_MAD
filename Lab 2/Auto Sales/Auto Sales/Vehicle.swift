//
//  Vehicle.swift
//  Auto Sales
//
//  Created by Mahmoud Aljarrash on 2/16/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation

class Vehicle
{
    var bodyType = String()
    var make = String()
    var model = String()
    var color = String()
    var mileage = Int()
    var price = Float()
    var year = String()
    
    
    init() {}
    
    init(bodyType:String, make:String, model:String, year:String)
    {
        self.bodyType = bodyType
        self.make = make
        self.model = model
        self.year = year
    }
    
    init(bodyType:String, make:String, model:String, year:String, color:String, price: Float, mileage: Int)
    {
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
