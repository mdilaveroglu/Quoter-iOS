//
//  PopularQuoesViewController.swift
//  Quoter
//
//  Created by argeus on 23.02.2016.
//  Copyright © 2016 argeus. All rights reserved.
//

import UIKit
import Font_Awesome_Swift
import MMDrawerController
import Alamofire

class PopularQuotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate  {
    
    
    @IBOutlet weak var navigationDrawerButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoButton: UIBarButtonItem!
    @IBOutlet weak var popularQuotesLoadingIndicator: UIActivityIndicatorView!
    
    var quotes = Array<Quote>()
    var favoriteQuotes = Array<Quote>()
    
    let defaults = NSUserDefaults.standardUserDefaults()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationDrawerButton.setFAIcon(FAType.FANavicon, iconSize: 25)
        infoButton.setFAIcon(FAType.FAInfoCircle, iconSize: 25)
        popularQuotesLoadingIndicator.startAnimating()
        self.tableView.tableFooterView = UIView()
        
        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "handlePopularQuotesLongPress:")
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self
        self.tableView.addGestureRecognizer(longPressGesture)
        
        Alamofire.request(.GET, "https://www.reddit.com/r/quotes.json")
            .responseJSON { response in
                                
                guard response.result.error == nil else {
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                
                if let value: AnyObject = response.result.value {
                    let json = JSON(value)
                    
                    if let children = json["data"]["children"].array{
                        self.parseRedditData(children)
                    }
                }
        }
    }
    
    func parseRedditData(data: [JSON]){
        for var i = 0; i < data.count ; ++i {
            if let quote = data[i]["data"]["title"].string {
                if quote.containsString("\""){
                    let newQuote = quote.stringByReplacingOccurrencesOfString("\"", withString: "")
                    
                    if newQuote.containsString("-"){
                        if let quoteString = newQuote.componentsSeparatedByString("-").first{
                            if let authorString = newQuote.componentsSeparatedByString("-").last{                                
                                quotes.append((Quote(quote: quoteString, author: authorString)))
                            }
                        }
                    }
                }
            }
        }
        self.tableView.reloadData()
        popularQuotesLoadingIndicator.stopAnimating()
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 176
    }

    
    @IBAction func navigationDrawerButtonTapped(sender: UIBarButtonItem) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    @IBAction func infoButtonTapped(sender: UIBarButtonItem) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let popularQuotesCell = tableView.dequeueReusableCellWithIdentifier("PopularQuotesCell", forIndexPath: indexPath) as! PopularQuotesCell
        
        popularQuotesCell.quote.text = quotes[indexPath.row].quote
        popularQuotesCell.author.text = quotes[indexPath.row].author
        
        
        popularQuotesCell.separatorInset = UIEdgeInsetsMake(0, 0, popularQuotesCell.frame.size.width, 0)
        if (popularQuotesCell.respondsToSelector("preservesSuperviewLayoutMargins")){
            popularQuotesCell.layoutMargins = UIEdgeInsetsZero
            popularQuotesCell.preservesSuperviewLayoutMargins = false
        }
        
        return popularQuotesCell
    }
    
    func handlePopularQuotesLongPress(longPressGesture: UILongPressGestureRecognizer){
        let p = longPressGesture.locationInView(self.tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(p)
        
        if indexPath == nil {
            print("Long press on table view, not row.")
        } else if (longPressGesture.state == UIGestureRecognizerState.Began) {
            showMultipleSelectionBox(indexPath!)
        }
    }
    
    
    func showMultipleSelectionBox(indexPath: NSIndexPath){
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        ac.addAction(UIAlertAction(title: "Save", style: .Default){ (action) in self.saveQuote(indexPath)})
        ac.addAction(UIAlertAction(title: "Share", style: .Default){ (action) in self.shareQuote(indexPath)})
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func saveQuote(indexPath: NSIndexPath!){
        let quoteToBeSaved = quotes[indexPath.row]
        if let savedQuotesData = defaults.objectForKey(StorageKeys.favoriteQuotes){
            favoriteQuotes = NSKeyedUnarchiver.unarchiveObjectWithData(savedQuotesData as! NSData) as! [Quote]

            if !favoriteQuotes.contains(quoteToBeSaved) {
                favoriteQuotes.append(quoteToBeSaved)
                
                let encodedData = NSKeyedArchiver.archivedDataWithRootObject(favoriteQuotes)
                defaults.setObject(encodedData, forKey: StorageKeys.favoriteQuotes)
                defaults.synchronize()

            }
        }else{
            let encodedData = NSKeyedArchiver.archivedDataWithRootObject([quoteToBeSaved])
            defaults.setObject(encodedData, forKey: StorageKeys.favoriteQuotes)
            defaults.synchronize()
        }
    }
    func shareQuote(indexPath: NSIndexPath!){
        print("SHARE")
    }
}
