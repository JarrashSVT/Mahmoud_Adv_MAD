//
//  DetailTableViewController.swift
//  NYTimes Most Viewed
//
//  Created by Mahmoud Aljarrash on 2/26/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var detailItem: String?
    var mostViewed = [MostViewed]()
    
    func configureView()
    {
        // Update the user interface for the detail item.
        let url = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/\(detailItem!)/1.json?api-key=cd1d1b1f267242b5bb682f8f92753b63"
        loadJSON(urlPath: url)
    }
    
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
            let api = try JSONDecoder().decode(API.self, from: data)
            
            for result in api.results
            {
                mostViewed.append(result)
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
        configureView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("DetailTableViewController -> numberOfSections()")
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("DetailTableViewController -> tableView_numberOfRowsInSection(\(mostViewed.count))")

        return mostViewed.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        print("DetailTableViewController -> tableView_cellForRowAt()")
        
        let mv =  mostViewed[indexPath.row]
        print(mv)
        cell.textLabel!.text = mostViewed[indexPath.row].title
        cell.detailTextLabel!.text = mostViewed[indexPath.row].byline
        // Configure the cell...

        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsSegue"
        {
            if let indexPath = tableView.indexPathForSelectedRow {
                let detailVC = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                detailVC.mostViewed = mostViewed[indexPath.row]
    
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
