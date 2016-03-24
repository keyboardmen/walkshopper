//
//  WSMineViewController.swift
//  WalkShopper
//
//  Created by dulingkang on 16/2/3.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

import UIKit

class WSMineViewController: UIViewController, WSMineHeaderViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var headerView: WSMineHeaderView!
    @IBOutlet weak var tableView: UITableView!
    let kDefaultCellHeight: CGFloat = 44
    let kImageCellHeight: CGFloat = 72
    var rowHeight: CGFloat = 44
    var tableList: [(String, String)] {
        get{
            return  [("收货地址管理", ""),
                     ("客服", ""),
                     ("关于", "")
            ]
        }
    }

    
    override func viewDidLoad() {
        headerView.headerViewDelegate = self
    }
    
    //MARK: - header view delegate
    func showUserInfoViewController() {
        let userInfoVC = UIStoryboard(name: "Mine", bundle: nil).instantiateViewControllerWithIdentifier("WSUserInfoViewController")
        self.navigationController?.showViewController(userInfoVC, sender: nil)
    }
    
    //MARK: - tableview datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return tableList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = MineCustomCell(style: .Detail, reuseIdentifier: MineCellType.Detail.identifier())
        if indexPath.section == 0 {
            switch indexPath.row {
            case 1:
                cell = MineCustomCell(style: .MultiButtons, reuseIdentifier: MineCellType.MultiButtons.identifier())
                rowHeight = kImageCellHeight
            default:
                cell.textLabel?.text = "我的订单"
                cell.detailTextLabel?.text = "查看全部订单"
                rowHeight = kDefaultCellHeight
                cell.accessoryType = .DisclosureIndicator
            }
        } else {
            cell.textLabel?.text = tableList[indexPath.row].0
            cell.detailTextLabel?.text = tableList[indexPath.row].1
            cell.accessoryType = .DisclosureIndicator
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 1 {
            return kImageCellHeight
        } else {
            return kDefaultCellHeight
        }
    }
}
