//
//  ViewController.swift
//  favorite quotes
//
//  Created by Mahmoud Aljarrash on 2/25/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let quotes = [Quote(body: "Have the courage to follow your heart and intuition. They somehow already know what you truly want to become. Everything else is secondary.", imageName: "steve1", by: "Steve Jobs"),
                  Quote(body: "Your time is limited, so don’t waste it living someone else’s life.", imageName: "steve2", by: "Steve Jobs"),
                  Quote(body: "Stay Hungry, Stay Foolish", imageName: "steve3", by: "Steve Jobs"),
                  Quote(body: "I don't have to be what you want me to be. I'm free to be what I want.ali", imageName: "ali1", by: "Muhammad Ali"),
                  Quote(body: "Silence is golden when you can't think of a good answer.", imageName: "ali2", by: "Muhammad Ali"),
                  Quote(body: "I hated every minute of training, but I said, “Don’t quit. Suffer now and live the rest of your life as a champion.”", imageName: "ali3", by: "Muhammad Ali")
                  ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

