//
//  FavoriteQuotesCell.swift
//  Quoter
//
//  Created by argeus on 29.02.2016.
//  Copyright © 2016 argeus. All rights reserved.
//

import UIKit

class FavoriteQuotesCell: UITableViewCell {

    @IBOutlet weak var quote: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
