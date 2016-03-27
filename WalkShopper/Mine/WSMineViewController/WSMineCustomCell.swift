//
//  WSMineCustomCell.swift
//  WalkShopper
//
//  Created by 丁 一 on 16/3/27.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

import UIKit

let WSMineCustomCellTitle = "WSMineCustomCellTitle"
let WSMineCustomCellDetailTitle = "WSMineCustomCellDetailTitle"


class WSMineCustomCell: WSTableViewCell {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var detailLabel: UILabel?
    
    func configCellWithData(data:NSDictionary)
    {
        self.titleLabel?.text = data[WSMineCustomCellTitle] as? String
        self.detailLabel?.text = data[WSMineCustomCellDetailTitle] as? String
        self.accessoryType = .DisclosureIndicator
    }

}
