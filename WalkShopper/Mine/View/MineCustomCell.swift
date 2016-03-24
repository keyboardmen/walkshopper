//
//  MineCustomCell.swift
//  WalkShopper
//
//  Created by dulingkang on 16/3/21.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

import UIKit

enum MineCellType {
    case Detail    //detail style
    case MultiButtons  //Four Image style
    func identifier() -> String! {
        switch self {
        case .MultiButtons:
            return "mineMultiButtonIdentifier"
        default:
            return "mineDetailIdentifier"
        }
    }
}

class MineCustomCell: UITableViewCell {

    //MARK: - life cycle
    init(style: MineCellType, reuseIdentifier: String) {
        
        switch style {
        case .Detail: super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        case .MultiButtons:
            super.init(style: .Default, reuseIdentifier: reuseIdentifier)
            configMultiButtonsCell()
        }
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    //MARK: - private method
    private func configMultiButtonsCell() {
        let orderImageName = ["Payment", "Order", "Receive", "Evaluate"]
        let orderName = ["待付款", "待接单", "待收货", "待评价"]
        let count = orderImageName.count
        for i in 0..<count {
            let fi = CGFloat(i)
            let fCount = CGFloat(count)
            let button = SSButton(frame: CGRectMake(kScreenWidth/fCount*fi, 0, kScreenWidth/fCount, self.height), type: .Bottom, imageNamePrefix: orderImageName[i])
            button.setTitle(orderName[i], forState: .Normal)
            self.addSubview(button)
        }
        
    }
}
