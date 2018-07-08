//
//  customsListCell.swift
//  projectManager_ShopOwner
//
//  Created by 黃恩祐 on 2018/7/8.
//  Copyright © 2018年 ENYUHUANG. All rights reserved.
//

import UIKit

class customsListCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
