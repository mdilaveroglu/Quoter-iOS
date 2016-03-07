//
//  AboutMeViewController.swift
//  Quoter
//
//  Created by argeus on 23.02.2016.
//  Copyright © 2016 argeus. All rights reserved.
//

import UIKit
import Font_Awesome_Swift
import MMDrawerController

class AboutMeViewController: UIViewController {

    @IBOutlet weak var navigationDrawerButton: UIBarButtonItem!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var facebookButton: UIButton!
    
    @IBOutlet weak var twitterButton: UIButton!
    
    @IBOutlet weak var linkedinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationDrawerButton.setFAIcon(FAType.FANavicon, iconSize: 25)
        facebookButton.setFAIcon(FAType.FAFacebook, forState: .Normal)
        twitterButton.setFAIcon(FAType.FATwitter, forState: .Normal)
        linkedinButton.setFAIcon(FAType.FALinkedin, forState: .Normal)
        
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor(red: 0, green: 150.0 / 255.0 , blue: 136.0 / 255.0, alpha: 1).CGColor
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func navigationDrawerButtonTapped(sender: UIBarButtonItem) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    @IBAction func emailTapped(sender: UIButton) {
        let url = NSURL(string: "mailto:mdilaveroglu@gmail.com")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    @IBAction func facebookTapped(sender: UIButton) {
        let webURL = NSURL(string: "https://www.facebook.com/mdilaveroglu")!
        let appURL = NSURL(string:"fb://profile/mdilaveroglu")!
        
        if(UIApplication.sharedApplication().canOpenURL(appURL)){
            // FB installe
            UIApplication.sharedApplication().openURL(appURL)
        } else {
            // FB is not installed, open in safari
            UIApplication.sharedApplication().openURL(webURL)
        }
    }

    @IBAction func twitterTapped(sender: UIButton) {
        let screenName =  "mdilaverm"
        let appURL = NSURL(string: "twitter://user?screen_name=\(screenName)")!
        let webURL = NSURL(string: "https://twitter.com/\(screenName)")!
        
        let application = UIApplication.sharedApplication()
        
        if application.canOpenURL(appURL) {
            application.openURL(appURL)
        } else {
            application.openURL(webURL)
        }
    }

    @IBAction func linkedinTapped(sender: UIButton) {
        let profileName =  "mdilaveroglu"
        let appURL = NSURL(string: "linkedin://profile/\(profileName)")!
        let webURL = NSURL(string: "https://linkedin.com/in/\(profileName)")!
        
        let application = UIApplication.sharedApplication()
        
        if application.canOpenURL(appURL) {
            application.openURL(appURL)
        } else {
            application.openURL(webURL)
        }
    }
}
