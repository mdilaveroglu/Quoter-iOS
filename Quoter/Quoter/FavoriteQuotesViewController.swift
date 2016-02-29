//
//  FavoriteQuotesViewController.swift
//  Quoter
//
//  Created by argeus on 23.02.2016.
//  Copyright © 2016 argeus. All rights reserved.
//

import UIKit
import Font_Awesome_Swift
import MMDrawerController
class FavoriteQuotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var navigationDrawerButton: UIBarButtonItem!
    @IBOutlet weak var noFavoriteQuotesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var quotes = Array<Quote>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationDrawerButton.setFAIcon(FAType.FANavicon, iconSize: 25)
        self.tableView.tableFooterView = UIView()
        
        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "handleFavoriteQuotesLongPress:")
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self
        self.tableView.addGestureRecognizer(longPressGesture)
        
        if quotes.isEmpty {
            noFavoriteQuotesLabel.hidden = false
        }
        
        
        for quote in quotes {
            print("Q: \(quote.quote)    A: \(quote.author) \n ")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func navigationDrawerButtonTapped(sender: UIBarButtonItem) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let favoriteQuotesCell = tableView.dequeueReusableCellWithIdentifier("FavoriteQuotesCell", forIndexPath: indexPath) as! FavoriteQuotesCell
        
        favoriteQuotesCell.quote.text = quotes[indexPath.row].quote
        favoriteQuotesCell.author.text = quotes[indexPath.row].author
        
        
        favoriteQuotesCell.separatorInset = UIEdgeInsetsMake(0, 0, favoriteQuotesCell.frame.size.width, 0)
        if (favoriteQuotesCell.respondsToSelector("preservesSuperviewLayoutMargins")){
            favoriteQuotesCell.layoutMargins = UIEdgeInsetsZero
            favoriteQuotesCell.preservesSuperviewLayoutMargins = false
        }
        
        return favoriteQuotesCell
    }
    
    func handleFavoriteQuotesLongPress(longPressGesture: UILongPressGestureRecognizer){
        let p = longPressGesture.locationInView(self.tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(p)
        
        if indexPath == nil {
            print("Long press on table view, not row.")
        } else if (longPressGesture.state == UIGestureRecognizerState.Began) {
            print("Long press on row, at \(indexPath!.row)")
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
        print("SAVE")
    }
    
    func shareQuote(indexPath: NSIndexPath!){
        print("SHARE")
    }

}
