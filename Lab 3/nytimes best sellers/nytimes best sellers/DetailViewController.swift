//
//  DetailViewController.swift
//  nytimes best sellers
//
//  Created by Mahmoud Aljarrash on 2/23/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var detailItem: Category?
    var bestSellerBooks = [BestSellerBooks]()
    var books = [Book]()
//    var firstCat: String
    
    @IBOutlet weak var label: UILabel!
    func configureView() {
        print("Configuring DetailViewController...")
        let list_name_encoded = detailItem?.list_name_encoded ?? ""
        let url = "https://api.nytimes.com/svc/books/v3/lists.json?api-key=cd1d1b1f267242b5bb682f8f92753b63&list=" + list_name_encoded
        
        loadJSON(urlPath: url)
        // Update the user interface for the detail item.
//        if let detail = detailItem {
//            if let label = detailDescriptionLabel {
//                label.text = detail.description
//            }
//        }
    }

    
    
    func loadJSON(urlPath: String)
    {
        print("Loading JSON from \(urlPath)")
        guard let  url = URL(string: urlPath)
            else
        {
            print("Error ")
            return
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
            DispatchQueue.main.async {self.parsejson(data!)}
        }
        session.resume()
    }
    
    func parsejson(_ data: Data)
    {
        print("2- parsing json ...")
        print(data)
        do
        {
            let api = try JSONDecoder().decode(BestSellerBooksAPI.self, from: data)
            
            for bsb in api.results
            {
                
                bestSellerBooks.append(bsb)
            }
            
            for book in bestSellerBooks
            {
                books.append(book.book_details[0])
            }
            print(books)
        }
        catch let jsonErr
        {
            print(jsonErr.localizedDescription)
            return
        }
        //reload the table data after the json data has been downloaded
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//    var detailItem: NSDate? {
//        didSet {
//            // Update the view.
//            configureView()
//        }
//    }

    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let book = books[indexPath.row]
        cell.textLabel!.text = book.title
        cell.detailTextLabel!.text = "By " + book.author
        
        return cell
    }


}

