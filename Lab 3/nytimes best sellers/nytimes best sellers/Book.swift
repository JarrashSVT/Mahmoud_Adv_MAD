//
//  Book.swift
//  nytimes best sellers
//
//  Created by Mahmoud Aljarrash on 2/23/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation

struct Book: Decodable
{
    let title: String
    let description: String
    let author: String
    let publisher: String
    let primary_isbn13: String
}
