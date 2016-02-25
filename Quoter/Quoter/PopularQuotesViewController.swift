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


class PopularQuotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    @IBOutlet weak var navigationDrawerButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoButton: UIBarButtonItem!
    @IBOutlet weak var popularQuotesLoadingIndicator: UIActivityIndicatorView!
    
    var quotes = Array<Quote>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationDrawerButton.setFAIcon(FAType.FANavicon, iconSize: 25)
        infoButton.setFAIcon(FAType.FAInfoCircle, iconSize: 25)
        popularQuotesLoadingIndicator.startAnimating()
        self.tableView.tableFooterView = UIView()
        
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
                                print(quoteString)
                                
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

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    

}
