//
//  WSMineOrderCell.swift
//  WalkShopper
//
//  Created by 丁 一 on 16/3/27.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

import UIKit

class WSMineOrderCell: WSTableViewCell {

    //MARK: - method
    func configCellWithData(data:NSDictionary)
    {
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
