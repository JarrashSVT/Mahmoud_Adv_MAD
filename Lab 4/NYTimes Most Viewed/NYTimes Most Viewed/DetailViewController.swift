//
//  DetailViewController.swift
//  NYTimes Most Viewed
//
//  Created by Mahmoud Aljarrash on 2/27/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var mostViewed: MostViewed?

    @IBAction func viewBtnTapped(_ sender: UIButton)
    {
        
        print("accessing", mostViewed!.url)
        if let url = URL(string: mostViewed!.url)
        {
            UIApplication.shared.open(url, options: [:])
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel!.text = mostViewed!.title
        abstractLabel!.text = mostViewed!.abstract
        byLabel!.text = mostViewed!.byline + " " + mostViewed!.published_date

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
