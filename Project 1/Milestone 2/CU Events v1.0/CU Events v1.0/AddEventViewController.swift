//
//  AddEventViewController.swift
//  CU Events v1.0
//
//  Created by Mahmoud Aljarrash on 2/23/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var eventTitleTxt: UITextField!
    @IBOutlet weak var locationTxt: UITextField!
    
    @IBAction func onSubmitBtnTapped(_ sender: UIButton)
    {
        guard let title = eventTitleTxt.text, title != "",
        let location = locationTxt.text, location != ""
            else
            {
                AlertController.showAlert(inViewController: self, title: "Missing Info", message: "Please fill out all fields")
                return
            }
        
        let parameter = ["title" : title,
                         "location" : location]
        
        print("parameter", parameter)
        DatabaseService.shared.eventsReference.childByAutoId().setValue(parameter)
        //fromAddEventVCToEventTVCSegue

        self.performSegue(withIdentifier: "fromAddEventVCToEventTVCSegue", sender: nil)

    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapGestureRecognized(_ sender: Any)
    {
        eventTitleTxt.resignFirstResponder()
        locationTxt.resignFirstResponder()
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
