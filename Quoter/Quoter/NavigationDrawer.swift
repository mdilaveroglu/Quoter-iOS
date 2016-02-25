//
//  NavigationDrawer.swift
//  Quoter
//
//  Created by argeus on 23.02.2016.
//  Copyright © 2016 argeus. All rights reserved.
//

import UIKit
import Font_Awesome_Swift
import MMDrawerController

class NavigationDrawer: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var menuItems:[NavigationDrawerItem] = [
        NavigationDrawerItem(icon: FAType.FAQuoteLeft, title: "Quote of the Day"),
        NavigationDrawerItem(icon: FAType.FALineChart, title: "Popular Quotes"),
        NavigationDrawerItem(icon: FAType.FAPlus, title: "Write Your Own"),
        NavigationDrawerItem(icon: FAType.FAHeart, title: "Favorite Quotes"),
        NavigationDrawerItem(icon: FAType.FAInfoCircle, title: "About Me"),
        NavigationDrawerItem(icon: FAType.FACopyright, title: "Credits")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.hidden = true
        UIApplication.sharedApplication().statusBarHidden = true;
        tableView.tableFooterView = UIView()
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let navDrawerCell = tableView.dequeueReusableCellWithIdentifier("NavDrawerCell", forIndexPath: indexPath) as! NavigationDrawerCell
        
        navDrawerCell.cellIcon.setFAIcon(menuItems[indexPath.row].icon, iconSize: 25)
        navDrawerCell.cellTitle.text = menuItems[indexPath.row].title
        
        navDrawerCell.separatorInset = UIEdgeInsetsMake(0, 0, navDrawerCell.frame.size.width, 0)
        if (navDrawerCell.respondsToSelector("preservesSuperviewLayoutMargins")){
            navDrawerCell.layoutMargins = UIEdgeInsetsZero
            navDrawerCell.preservesSuperviewLayoutMargins = false
        }
        
        return navDrawerCell
        
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let qodViewController = self.storyboard?.instantiateViewControllerWithIdentifier("QODViewController") as! QODViewController
            let qodNavController = UINavigationController(rootViewController: qodViewController);
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = qodNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        case 1:
            let popularQuotesViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PopularQuotesViewController") as! PopularQuotesViewController
            let popularQuotesNavController = UINavigationController(rootViewController: popularQuotesViewController);
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = popularQuotesNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        case 2:
            let writeYourOwnViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WriteYourOwnViewController") as! WriteYourOwnViewController
            let writeYourOwnNavController = UINavigationController(rootViewController: writeYourOwnViewController);
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = writeYourOwnNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        case 3:
            let favoriteQuotesViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FavoriteQuotesViewController") as! FavoriteQuotesViewController
            let favoriteQuotesNavController = UINavigationController(rootViewController: favoriteQuotesViewController);
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = favoriteQuotesNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        case 4:
            let aboutMeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AboutMeViewController") as! AboutMeViewController
            let aboutMeNavController = UINavigationController(rootViewController: aboutMeViewController);
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = aboutMeNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        case 5:
            print("Credits")
            
            let creditsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CreditsViewController") as! CreditsViewController
            let creditsNavController = UINavigationController(rootViewController: creditsViewController);
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = creditsNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        default:
            break;
        }

    }
}
