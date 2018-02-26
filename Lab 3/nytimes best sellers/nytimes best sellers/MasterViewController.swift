//
//  MasterViewController.swift
//  nytimes best sellers
//
//  Created by Mahmoud Aljarrash on 2/23/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var categories = [Category]()
    let url = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=cd1d1b1f267242b5bb682f8f92753b63"
    
    func loadJSON(urlPath: String)
    {
        guard let  url = URL(string: urlPath)
            else
        {
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
        print("parsing json ...")
        print(data)
        do
        {
            let api = try JSONDecoder().decode(CategoriesAPI.self, from: data)
            
            for petition in api.results
            {
                categories.append(petition)
            }
            
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
        loadJSON(urlPath: url)
    
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let cat = categories[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = cat
                controller.title = cat.list_name
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let cat = categories[indexPath.row]
        cell.textLabel!.text = cat.display_name
        cell.detailTextLabel!.text = cat.updated

        return cell
    }

    


}

