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
import Alamofire

enum QODStorageKeys {
    static let quote = "quote"
    static let author = "author"
}

extension String {
    mutating func stripFromCharacter(char:String) {
        let c = self.characters
        if let ix = c.indexOf("\"") {
            self = String(c.prefixUpTo(ix))
        }
    }
    
    var html2AttributedString: NSAttributedString? {
        guard
            let data = dataUsingEncoding(NSUTF8StringEncoding)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func sliceFrom(start: String, to: String) -> String? {
        return (rangeOfString(start)?.endIndex).flatMap { sInd in
            (rangeOfString(to, range: sInd..<endIndex)?.startIndex).map { eInd in
                substringWithRange(sInd..<eInd)
            }
        }
    }
}

class QODViewController: UIViewController {

    @IBOutlet weak var navigationDrawerButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    @IBOutlet weak var qodQuote: UILabel!
    @IBOutlet weak var qodAuthor: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationDrawerButton.setFAIcon(FAType.FANavicon, iconSize: 25)
        shareButton.setFAIcon(FAType.FAShareAlt, iconSize: 25)
        favoriteButton.setFAIcon(FAType.FAHeart, iconSize: 25)
        
        if let savedQuote = defaults.stringForKey(QODStorageKeys.quote){
            qodQuote.text = savedQuote
        }else{
            loadingIndicator.startAnimating()
        }
        
        if let savedAuthor = defaults.stringForKey(QODStorageKeys.author){
            qodAuthor.text = savedAuthor
        }
        
        Alamofire.request(.GET, "https://en.wikiquote.org/w/api.php?format=json&action=parse&page=Template:QoD&prop=text")
            .responseJSON { response in
                
                self.loadingIndicator.stopAnimating()
                
                guard response.result.error == nil else {
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                
                if let value: AnyObject = response.result.value {
                    let json = JSON(value)
                    
                    if let content = json["parse"]["text"]["*"].string{
                        self.parseReceivedString(content.html2String.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))
                    }
                }
        }
    }
    
    func parseReceivedString(string: String){
        let quoteString = string.componentsSeparatedByString("~").first
        let authorString = string.sliceFrom("~", to: "~")
        
        
        defaults.setValue(quoteString, forKey: QODStorageKeys.quote)
        defaults.setValue(authorString, forKey: QODStorageKeys.author)
        defaults.synchronize()
        
        qodQuote.text = quoteString
        qodAuthor.text = authorString
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

