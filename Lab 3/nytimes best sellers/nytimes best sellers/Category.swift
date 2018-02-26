//
//  Category.swift
//  nytimes best sellers
//
//  Created by Mahmoud Aljarrash on 2/23/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation

struct Category: Decodable
{
    let list_name: String
    let display_name: String
    let list_name_encoded: String
    let updated: String
}
