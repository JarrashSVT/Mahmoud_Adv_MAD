//
//  ViewController.swift
//  Auto Sales
//
//  Created by Mahmoud Aljarrash on 2/16/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    var cars = [String]()
    var bodyStyles = ["Coupe", "SUV", "Convertible", "Sedan", "Wagon"]
    var inventory = VehiclesInventory()
    let kfilename = "data16.plist"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        var defualtplist = "cars"
        
        let fileStatus = isFileExists(plistName: kfilename)
        
        // check if kfilename exists
        if fileStatus.fileExists
        {
            print("viewDidLoad() -> \(kfilename) exists")
            cars = getDataArrayFromPlist(plistNameURL: fileStatus.path)
        }
        else
        {
            print("viewDidLoad() -> \(kfilename) does NOT exists")
            print("viewDidLoad() -> default plist file will be used")
            cars = getDataArrayFromPlist(plistName: "cars")
        }
        

        
        // add Vehicle objects to the array
        for car in cars
        {
            print(car)
            let carDetails = car.split(separator: ";")
            let v = Vehicle(bodyType: String(carDetails[0]), make: String(carDetails[1]), model: String(carDetails[2]), year: String(carDetails[3]), color: String(carDetails[4]), price: Float(carDetails[5])!, mileage: Int(carDetails[6])! )
            //let v = Vehicle()
            // print(carDetails[5])
            inventory.vehicleList.append(v)
            
        }
        //application instance
        let app = UIApplication.shared
        //subscribe to the UIApplicationWillResignActiveNotification notification
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.applicationWillResignActive(_:)), name: NSNotification.Name.UIApplicationWillResignActive, object: app)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return bodyStyles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = bodyStyles[indexPath.row]
        return cell
    }
    
    func getDataArrayFromPlist(plistName: String) -> Array<String>
    {
        print("getDateArrayFromPlist(\(plistName))")
        // URL for our plist
        var dataArray = [String]()
        if let pathURL = Bundle.main.url(forResource: plistName, withExtension: "plist")
        {
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do
            {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                dataArray = try plistdecoder.decode([String].self, from: data)
            } catch
            {
                // handle error
                print(error)
            }
        }
        return dataArray
    }
    
    func getDataArrayFromPlist(plistNameURL: URL) -> Array<String>
    {
        print("getDateArrayFromPlist(\(plistNameURL.absoluteString))")
        // URL for our plist
        var dataArray = [String]()
//        if let pathURL = plistNameURL //Bundle.main.url(forResource: plistName, withExtension: "plist")
//        {
            let pathURL = plistNameURL
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do
            {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                dataArray = try plistdecoder.decode([String].self, from: data)
            } catch
            {
                // handle error
                print(error)
            }
//        }
        return dataArray
    }
    func isFileExists(plistName: String) -> (fileExists:Bool, path: URL)
    {
        let pathURL:URL?
        //get path for data file
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0] //documents directory
        print(docDir)
        
        // URL for our plist
        let dataFileURL = docDir.appendingPathComponent(plistName)
        print(dataFileURL)
        
        //if the data file exists, use it
        if FileManager.default.fileExists(atPath: dataFileURL.path)
        {
            pathURL = dataFileURL
            return (true,pathURL!)
        }
        else
        {
            pathURL = dataFileURL
            return (false, pathURL!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("prepare for segue ...")

        if segue.identifier == "toVehiclesTableVcSegue"
        {
            print("toVehiclesTableVcSegue")
            // get the index for tapped cell
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            print("indexPath = ", indexPath.row)
            
            let vehiclesVC = segue.destination as! VehiclesTableViewController
            
            vehiclesVC.bodyStyle = bodyStyles[indexPath.row]
            vehiclesVC.cars = cars
            vehiclesVC.title = bodyStyles[indexPath.row]
            vehiclesVC.inventory = inventory
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //called when the UIApplicationWillResignActiveNotification notification is posted
    //all notification methods take a single NSNotification instance as their argument
    @objc func applicationWillResignActive(_ notification: NSNotification)
    {
        //AlertController.showAlert(inViewController: self, title: "<#T##String#>", message: "<#T##String#>")
        //get path for data file
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0] //documents directory
        print(docDir)
        
        // URL for our plist
        let dataFileURL = docDir.appendingPathComponent(kfilename)
        print(dataFileURL)
        //creates a property list decoder object
        let plistencoder = PropertyListEncoder()
        plistencoder.outputFormat = .xml
        do
        {
            print("saving cars ...")
            print("cars list is: \(inventory.toString())")
            let data = try plistencoder.encode(inventory.toString())
            try data.write(to: dataFileURL)
        } catch
        {
            // handle error
            print(error)
        }
    }


}

