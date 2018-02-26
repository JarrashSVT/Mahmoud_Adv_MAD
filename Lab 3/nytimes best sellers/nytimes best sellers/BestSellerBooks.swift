//
//  BestSellerBooks.swift
//  nytimes best sellers
//
//  Created by Mahmoud Aljarrash on 2/23/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation

struct BestSellerBooks: Decodable
{
    let rank: Int
    let amazon_product_url: String
    let book_details: [Book]
}
