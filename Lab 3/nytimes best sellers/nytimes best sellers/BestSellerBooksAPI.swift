//
//  BestSellerBooksAPI.swift
//  nytimes best sellers
//
//  Created by Mahmoud Aljarrash on 2/23/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation

struct BestSellerBooksAPI: Decodable
{
    let results: [BestSellerBooks]
}
