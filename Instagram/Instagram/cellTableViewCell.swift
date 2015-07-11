//
//  cellTableViewCell.swift
//  Instagram
//
//  Created by Ramesh Vaidyalingam on 12/2/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

class cellTableViewCell: UITableViewCell {

    @IBOutlet weak var postedImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var username: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
