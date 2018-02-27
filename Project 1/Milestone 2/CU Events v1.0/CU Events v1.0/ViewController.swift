//
//  ViewController.swift
//  CU Events v1.0
//
//  Created by Mahmoud Aljarrash on 2/23/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var addEventBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        if anyUserLoggedIn()
        {
            print("Someone logged in")
            loginBtn.isHidden = true
            addEventBtn.isHidden = false
            logoutBtn.isHidden = false
            guard let username = Auth.auth().currentUser?.displayName, username != ""
            else
            {
                return
            }
            usernameLabel.text = "Welcome, \(username)"
        }
        else
        {
            print("No one logged in")
            loginBtn.isHidden = false
            addEventBtn.isHidden = true
            logoutBtn.isHidden = true
            usernameLabel.text = ""
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func anyUserLoggedIn() -> Bool
    {
        guard (Auth.auth().currentUser?.displayName) != nil
            else
            {
                return false
            }
        
        return true
    }
    
    @IBAction func unwingSegue(_ segue: UIStoryboardSegue)
    {
        print("ViewController -> unwingSegue()")
    }
    
    //Logout
    @IBAction func onLogoutBtnTapped(_ sender: UIButton)
    {
        print("Trying to logout...")
        do
        {
            try Auth.auth().signOut()
//            performSegue(withIdentifier: "signOutSegue", sender: nil)
            print("Logged out successfully.")
            self.viewWillAppear(true)
            
        } catch
        {
            print(error)
        }
    }
    
}

