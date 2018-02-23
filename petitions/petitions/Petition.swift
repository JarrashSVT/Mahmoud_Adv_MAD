//
//  Petition.swift
//  petitions
//
//  Created by Mahmoud Aljarrash on 2/22/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation

struct Petition : Decodable
{
    let title: String
    let signatureCount: Int
    let url: String
}
