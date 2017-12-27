//
//  RouteCell.swift
//  HualienBus
//
//  Created by robinson on 2017/12/27.
//  Copyright © 2017年 robinson. All rights reserved.
//

import UIKit

class RouteCell: UITableViewCell {

    @IBOutlet weak var plate: UILabel!
    @IBOutlet weak var routeId: UILabel!
    @IBOutlet weak var routeName: UILabel!
    @IBOutlet weak var drivingImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
