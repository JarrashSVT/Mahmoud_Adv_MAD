//
//  NewVehicleViewController.swift
//  Auto Sales
//
//  Created by Mahmoud Aljarrash on 2/17/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class NewVehicleViewController: UIViewController
{

    
    @IBOutlet weak var makeTxt: UITextField!
    @IBOutlet weak var modelTxt: UITextField!
    @IBOutlet weak var yearTxt: UITextField!
    @IBOutlet weak var bodyStyleTxt: UITextField!
    @IBOutlet weak var colorTxt: UITextField!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var mileageTxt: UITextField!
    
    var newVehicle = Vehicle()
    var bodyStyle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyStyleTxt.text = bodyStyle
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onTapGestureRecognized(_ sender: Any)
    {
        makeTxt.resignFirstResponder()
        modelTxt.resignFirstResponder()
        yearTxt.resignFirstResponder()
        colorTxt.resignFirstResponder()
        priceTxt.resignFirstResponder()
        mileageTxt.resignFirstResponder()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "saveSegue"
        {
            guard let make = makeTxt.text,
            make != "",
            let model = modelTxt.text,
            model != "",
            let year = yearTxt.text,
            year != "",
            let color = colorTxt.text,
            color != "",
            let price = priceTxt.text,
            price != "",
            let mileage = mileageTxt.text,
            mileage != ""
            else
            {
//                AlertController.showAlert(inViewController: self, title: "Missing Info", message: "Please fill out all fields")
                return
            }
                
            newVehicle = Vehicle(bodyType: bodyStyle, make: make, model: model, year: year, color: color, price: Float(price)!, mileage: Int(mileage)!)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
