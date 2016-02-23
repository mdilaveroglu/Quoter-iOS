//
//  ViewController.swift
//  Quoter
//
//  Created by argeus on 23.02.2016.
//  Copyright © 2016 argeus. All rights reserved.
//

import UIKit
import MMDrawerController
import Font_Awesome_Swift

class QODViewController: UIViewController {

    @IBOutlet weak var navigationDrawerButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationDrawerButton.setFAIcon(FAType.FANavicon, iconSize: 25)
        shareButton.setFAIcon(FAType.FAShareAlt, iconSize: 25)
        favoriteButton.setFAIcon(FAType.FAHeart, iconSize: 25)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func navigationDrawerButtonTapped(sender: UIBarButtonItem) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)        
    }
    @IBAction func shareButtonTapped(sender: UIBarButtonItem) {
        
        
    }
    @IBAction func favoriteButtonTapped(sender: UIBarButtonItem) {
    }
}

