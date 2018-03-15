//
//  RealmService.swift
//  Mahmoud_Midterm
//
//  Created by Mahmoud Aljarrash on 3/15/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService
{
    static let shared = RealmService()
    private init(){}
    
    var realm = try! Realm()
    
    func save(restaurant: Restaurant)
    {
        do
        {
            try realm.write
            {
                realm.add(restaurant)
            }
        } catch
        {
            print(error.localizedDescription)
        }
    }
    
    //
    func delete(restaurant: Restaurant)
    {
        do
        {
            try realm.write {
                realm.delete(restaurant)
            }
        } catch
        {
            print(error.localizedDescription)
        }
    }
    
   
}
