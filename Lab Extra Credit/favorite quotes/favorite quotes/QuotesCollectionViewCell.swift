//
//  QuotesCollectionViewCell.swift
//  favorite quotes
//
//  Created by Mahmoud Aljarrash on 2/25/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class QuotesCollectionViewCell: UICollectionViewCell
{
     
    @IBOutlet weak var img: UIImageView!
    
    var imageName: String!{
        didSet{
            img.image = UIImage(named: imageName)
            
        }
    }
    
}
