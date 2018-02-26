//
//  DetailViewController.swift
//  favorite quotes
//
//  Created by Mahmoud Aljarrash on 2/25/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var quoteImage: UIImageView!
    @IBOutlet weak var quoteBody: UITextView!
    var q = Quote(body: "", imageName: "", by : "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteImage.image = UIImage(named: q.imageName)
        navigationItem.title = q.by
        quoteBody.text = q.body
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        var imageArray = [UIImage]()
        imageArray.append(quoteImage.image!)
        let shareScreen = UIActivityViewController(activityItems: imageArray, applicationActivities: nil)
        shareScreen.modalPresentationStyle = .popover
        shareScreen.popoverPresentationController?.barButtonItem = sender
        present(shareScreen, animated: true, completion: nil)
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
