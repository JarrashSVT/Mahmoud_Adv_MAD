//
//  HeaderCollectionReusableView.swift
//  favorite quotes
//
//  Created by Mahmoud Aljarrash on 2/25/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView
{
    @IBOutlet weak var quoteByLabel: UILabel!
    
    
    var quoteBy: String!
    {
        didSet
        {
            quoteByLabel.text = quoteBy
        }
    }
}

