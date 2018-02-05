//
//  SecondViewController.swift
//  CU Courses
//
//  Created by Mahmoud Aljarrash on 1/29/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBAction func goToCanvas(_ sender: UIButton)
    {
        if(UIApplication.shared.canOpenURL(URL(string: "canvas-courses://")!))
        {
            UIApplication.shared.open(URL(string: "canvas-courses://cuboulder.instructure.com/")!, options: [:], completionHandler: nil)
        }
        else
        {
            UIApplication.shared.open(URL(string: "http://cuboulder.instructure.com")!, options: [:], completionHandler: nil)
        }
    }
    @IBAction func GoTo(_ sender: UIButton)
    {
        if(UIApplication.shared.canOpenURL(URL(string: "spotify://")!))
        {
            UIApplication.shared.open(URL(string: "spotify://")!, options: [:], completionHandler: nil)
        }
        else
        {
            UIApplication.shared.open(URL(string: "http://www.apple.com")!, options: [:], completionHandler: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

