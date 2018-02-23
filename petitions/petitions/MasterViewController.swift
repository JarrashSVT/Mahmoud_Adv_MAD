//
//  MasterViewController.swift
//  petitions
//
//  Created by Mahmoud Aljarrash on 2/22/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailVC: DetailViewController? = nil
    var petitions = [Petition]()
    
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    let urlPath = "https://api.whitehouse.gov/v1/petitions.json?limit=50"
    
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
            
            guard statusCode == 200
            else
            {
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
            let api = try JSONDecoder().decode(API.self, from: data)
            
            for petition in api.results
            {
                petitions.append(petition)
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
//        navigationItem.leftBarButtonItem = editButtonItem
        loadJSON(urlPath: urlPath)
  
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
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let petition = petitions[indexPath.row]
                let title = petition.title
                let url = petition.url
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = url
                controller.title = title
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        print(petition)
        cell.textLabel!.text = petition.title
        cell.detailTextLabel!.text = String(petition.signatureCount) + " signatures"
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            objects.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }


}

