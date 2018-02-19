//
//  VehiclesInventory.swift
//  Auto Sales
//
//  Created by Mahmoud Aljarrash on 2/17/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation

class VehiclesInventory
{
    var vehicleList = [Vehicle]()
    
    func toString() -> [String] {
        var list = [String]()
        
        for v in self.vehicleList
        {
            list.append(v.toString())
        }
        
    return list
    }
    
    func getIndex(vehicle: Vehicle) -> Int
    {
        var index = 0
        
        for v in self.vehicleList
        {
            if v.bodyType == vehicle.bodyType && v.make == vehicle.make && v.model == vehicle.model && v.color == vehicle.color && v.price == vehicle.price && v.mileage == vehicle.mileage
            {
                return index
            }
            index = index + 1
        }
        return -1
    }
}
