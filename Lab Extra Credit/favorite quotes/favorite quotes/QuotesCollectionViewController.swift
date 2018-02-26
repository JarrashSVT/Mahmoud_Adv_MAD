
//  QuotesCollectionViewController.swift
//  favorite quotes
//
//  Created by Mahmoud Aljarrash on 2/25/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class QuotesCollectionViewController: UICollectionViewController {

    
    var quotes = [Quotes]()
    
    let ali = [Quote(body: "I don't have to be what you want me to be. I'm free to be what I want.ali", imageName: "ali", by: "Muhammad Ali"),
               Quote(body: "Silence is golden when you can't think of a good answer.", imageName: "ali2", by: "Muhammad Ali"),
               Quote(body: "I hated every minute of training, but I said, “Don’t quit. Suffer now and live the rest of your life as a champion.”", imageName: "ali3", by: "Muhammad Ali")]
    
    let jobs = [Quote(body: "Have the courage to follow your heart and intuition. They somehow already know what you truly want to become. Everything else is secondary.", imageName: "jobs1", by: "Steve Jobs"),
                Quote(body: "Your time is limited, so don’t waste it living someone else’s life.", imageName: "jobs2", by: "Steve Jobs"),
                Quote(body: "Stay Hungry, Stay Foolish", imageName: "jobs3", by: "Steve Jobs")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quotes = [Quotes(by:"Muhammad Ali", list: ali),
                  Quotes(by:"Steve Jobs", list: jobs)]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("numberOfSections ",quotes.count)
        return quotes.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print("section", section)
        let q = quotes[section]
        print("numberOfItemsInSection", q.list.count)
        return q.list.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! QuotesCollectionViewCell

        // Configure the cell
//        print(quotes[indexPath.row]!)
        
        print("index", indexPath.section)
//        print(quotes[indexPath.section].list)
        cell.imageName = quotes[indexPath.section].list[indexPath.row].imageName
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderCollectionReusableView
        
        header.quoteBy = quotes[indexPath.section].list[indexPath.row].by
//        print(quotes[indexPath.row].by)
//        print("index", indexPath.row)
        return header
    }


    // MARK: UICollectionViewDelegate
    var selectQuote = Quote(body: "", imageName: "", by : "")
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let image = quotes[indexPath.section].list[indexPath.row].imageName
        let by = quotes[indexPath.section].list[indexPath.row].by
        let body = quotes[indexPath.section].list[indexPath.row].body
        
        selectQuote = Quote(body: body, imageName: image, by: by)
        
        performSegue(withIdentifier: "showQuoteSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuoteSegue"
        {
            let detailVC = segue.destination as! DetailViewController
            detailVC.q = selectQuote
        }
    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
