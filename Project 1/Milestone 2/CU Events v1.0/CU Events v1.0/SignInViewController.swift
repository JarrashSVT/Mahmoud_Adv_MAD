//
//  SignInViewController.swift
//  CU Events v1.0
//
//  Created by Mahmoud Aljarrash on 2/23/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBAction func onSignInBtnTapped(_ sender: UIButton)
    {
        print("SignInViewController -> onSignInBtnTapped()")
        guard let email = emailTxt.text,
            email != "",
            let password = passwordTxt.text,
            password != ""
            else
        {
            AlertController.showAlert(inViewController: self, title: "Missing Info", message: "Please fill out all required fields")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            guard err == nil else
            {
                print("wrong user name")
                
                AlertController.showAlert(inViewController: self, title: "Error", message: err!.localizedDescription)
                return
            }
            
            guard let user = user else
            {
                print("Something wrong with the user!!")
                return
            }
            
            print(user.email ?? "Missing Email")
            print(user.displayName ?? "Missing Display Name")
            print(user.uid)
            
            
            self.performSegue(withIdentifier: "fromSignInToAddEventVCSegue", sender: nil)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.performSegue(withIdentifier: "toAddEventVCSegue", sender: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
