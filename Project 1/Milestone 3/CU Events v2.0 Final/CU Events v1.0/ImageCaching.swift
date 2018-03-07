//
//  ImageCaching.swift
//  CU Events v1.0
//
//  Created by Mahmoud Aljarrash on 3/6/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

// create the cache
let cache = NSCache<AnyObject , UIImage>()

extension UIImageView
{
    func downloadAndCacheImage(fromUrl: String)
    {
        self.image = nil
        // checking if the url/image is already download
        if let imageCached = cache.object(forKey: fromUrl as AnyObject)
        {
            self.image = imageCached
            return
        }
        
        // image in the url is not cached, so we will start downloading
        let url = URL(string: fromUrl)
        let session = URLSession.shared.dataTask(with: url!) { (date, response, error) in
            
            guard error == nil else
            {
                print(error!.localizedDescription)
                return
            }
            
            // Download image successful
            DispatchQueue.main.async {
               if let downloadedImg = UIImage(data: date!)
               {
                // add the downloaded image to the cache.
                cache.setObject(downloadedImg, forKey: fromUrl as AnyObject)
                // set the downloaded image
                self.image = downloadedImg
               }
            }
            
        }
        session.resume()
    }
}
