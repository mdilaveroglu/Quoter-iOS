//
//  NavigationDrawerItem.swift
//  Quoter
//
//  Created by argeus on 23.02.2016.
//  Copyright © 2016 argeus. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

class NavigationDrawerItem: NSObject {
    
    var icon: FAType;
    var title: String;
    
    init(icon: FAType, title: String) {
        self.icon = icon
        self.title = title;
    }

}
