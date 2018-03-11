//
//  RealmService.swift
//  Auto Sales
//
//  Created by Mahmoud Aljarrash on 3/8/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService
{
    static let share = RealmService()
    private init(){}
    
    var realm = try! Realm()
    
    func save(vehicle v: Vehicle)
    {
        do
        {
            try realm.write
            {
                realm.add(v)
            }
        } catch
        {
            print(error.localizedDescription)
        }
    }
    
    
    func delete(vehicle v: Vehicle)
    {
        do
        {
            try realm.write {
                realm.delete(v)
            }
        } catch
        {
            print(error.localizedDescription)
        }
    }
}
