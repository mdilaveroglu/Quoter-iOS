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


class PopularQuotesViewController: UIViewController {
    
    
    @IBOutlet weak var navigationDrawerButton: UIBarButtonItem!
    @IBOutlet weak var infoButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationDrawerButton.setFAIcon(FAType.FANavicon, iconSize: 25)
        infoButton.setFAIcon(FAType.FAInfoCircle, iconSize: 25)
    }

    
    @IBAction func navigationDrawerButtonTapped(sender: UIBarButtonItem) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    @IBAction func infoButtonTapped(sender: UIBarButtonItem) {
    }

}
