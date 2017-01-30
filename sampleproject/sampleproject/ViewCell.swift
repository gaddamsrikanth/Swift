//
//  ViewCell.swift
//  sampleproject
//
//  Created by Developer88 on 1/30/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class ViewCell: UITableViewCell {

    @IBOutlet var lbl1: UILabel!
    @IBOutlet var imgview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
