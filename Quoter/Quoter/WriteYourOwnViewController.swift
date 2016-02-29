//
//  WriteYourOwnViewController.swift
//  Quoter
//
//  Created by argeus on 23.02.2016.
//  Copyright © 2016 argeus. All rights reserved.
//

import UIKit
import Font_Awesome_Swift
import MMDrawerController

class WriteYourOwnViewController: UIViewController{

    @IBOutlet weak var navigationDrawerButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var quoteInput: UITextField!
    @IBOutlet weak var authorInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationDrawerButton.setFAIcon(FAType.FANavicon, iconSize: 25)
        doneButton.setFAIcon(FAType.FACheck, iconSize: 25)
        shareButton.setFAIcon(FAType.FAShareAlt, iconSize: 25)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func navigationDrawerButtonTapped(sender: UIBarButtonItem) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
    }
    
    @IBAction func shareButtonTapped(sender: UIBarButtonItem) {
    }
    
}
