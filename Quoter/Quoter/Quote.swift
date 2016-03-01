//
//  Quote.swift
//  Quoter
//
//  Created by argeus on 25.02.2016.
//  Copyright © 2016 argeus. All rights reserved.
//

import UIKit

class Quote: NSObject, NSCoding {
    
    var quote: String;
    var author: String;
    
    init(quote: String, author: String) {
        self.quote = quote
        self.author = author;
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let quote = aDecoder.decodeObjectForKey("quote") as! String
        let author = aDecoder.decodeObjectForKey("author") as! String
        self.init(quote: quote, author: author)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(quote, forKey: "quote")
        aCoder.encodeObject(author, forKey: "author")
    }

    override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? Quote {
            return quote == object.quote
        } else {
            return false
        }
    }

}
