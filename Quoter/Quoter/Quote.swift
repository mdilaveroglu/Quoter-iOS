//
//  Quote.swift
//  Quoter
//
//  Created by argeus on 25.02.2016.
//  Copyright © 2016 argeus. All rights reserved.
//

import UIKit

class Quote: NSObject {
    
    var quote: String;
    var author: String;
    
    init(quote: String, author: String) {
        self.quote = quote
        self.author = author;
    }


}
