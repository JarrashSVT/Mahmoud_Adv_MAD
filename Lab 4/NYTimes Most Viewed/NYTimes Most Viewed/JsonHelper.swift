//
//  JsonHelper.swift
//  NYTimes Most Viewed
//
//  Created by Mahmoud Aljarrash on 2/26/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation

class JsonHelper
{
    var baseUrl: String
    var results: [MostViewed]
    
    init(url: String)
    {
        self.baseUrl = url
        self.results = [MostViewed]()
//        self.loadJSON()
    }
    
    
    func loadJSON() //-> [Any]
    {
//        var anyArray = [Any]()

        guard let  url = URL(string: self.baseUrl)
            else
        {
            print("Error during loadJSON(\(self.baseUrl)...")
            return //anyArray
        }
        
        let session = URLSession.shared.dataTask(with: url) { (data, res, error) in
            let httpRes = res as! HTTPURLResponse
            let statusCode = httpRes.statusCode
            
            guard error == nil else
            {
                print(error!.localizedDescription)
                return
            }
            guard statusCode == 200
                else
            {
                print("HTTP Error Code: \(statusCode)")
                print("file download error")
                return
            }
            print("download complete")
            DispatchQueue.main.async
            {
               self.parsejson(data!)}
            }
        session.resume()
//        print("JsonHelper -> loadJSON() -> results Size = \(results.count)")

//        return anyArray
    }
    
    func parsejson(_ data: Data)
    {
//        var anyArray = [Any]()
        print("parsing json ...")
        print(data)
        do
        {
            let api = try JSONDecoder().decode(API.self, from: data)
            
            for result in api.results
            {
//                categories.append(petition)
//                print(result.title)
                self.results.append(result)
            }
            
        }
        catch let jsonErr
        {
            print(jsonErr.localizedDescription)
            return
        }
        //reload the table data after the json data has been downloaded
        print("anyArray Size = \(self.results.count)")
        print(self.results)
//        return anyArray
    }
   
}
