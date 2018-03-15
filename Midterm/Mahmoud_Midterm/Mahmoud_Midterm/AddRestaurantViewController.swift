//
//  AddRestaurantViewController.swift
//  Mahmoud_Midterm
//
//  Created by Mahmoud Aljarrash on 3/15/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class AddRestaurantViewController: UIViewController {

    @IBOutlet weak var urlTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    
    var addedRestaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "saveSegue"
        {
            guard let name = nameTxt.text, name != "",
                let url = urlTxt.text, url != "" else {return}
            
            addedRestaurant = Restaurant(name: name, url: url)

        }
        
    }
    
    @IBAction func onTapGestureRecognized(_ sender: Any)
    {
        nameTxt.resignFirstResponder()
        urlTxt.resignFirstResponder()
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
