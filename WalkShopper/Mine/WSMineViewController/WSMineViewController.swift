//
//  WSMineViewController.swift
//  WalkShopper
//
//  Created by dulingkang on 16/2/3.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

import UIKit

let customCellIdentifier : String = "Mine Custom Cell"
let orderCellIdentifier : String = "Mine Order Cell"
let kDefaultCellHeight: CGFloat = 44
let kImageCellHeight: CGFloat = 72

class WSMineViewController: UIViewController, WSMineHeaderViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var headerView: WSMineHeaderView!
    @IBOutlet weak var tableView: UITableView!
    
    var cellHeightArray : [[CGFloat]] = [
        [kDefaultCellHeight, kImageCellHeight, kDefaultCellHeight],
        [kDefaultCellHeight],
        [kDefaultCellHeight]
    ]

    
    var cellIdentifierArray : [[String]] = [
        [customCellIdentifier, orderCellIdentifier, customCellIdentifier],
        [customCellIdentifier],
        [customCellIdentifier]
    ]
    
    var dataSource : Array<Array<NSDictionary>> = [
        [[WSMineCustomCellTitle:"我的订单", WSMineCustomCellDetailTitle:"查看全部订单"], [:],[WSMineCustomCellTitle:"收货地址管理", WSMineCustomCellDetailTitle:""]],
        [[WSMineCustomCellTitle:"客服", WSMineCustomCellDetailTitle:""]],
        [[WSMineCustomCellTitle:"关于", WSMineCustomCellDetailTitle:""]]
    ]

    override func viewDidLoad() {
        self.edgesForExtendedLayout = UIRectEdge.None
        self.tableView.tableHeaderView = self.headerView
        headerView.headerViewDelegate = self
        
        self.tableView.tableFooterView = UIView();
        self.tableView.separatorStyle = .SingleLine;
    }
    
    //MARK: - header view delegate
    func showUserInfoViewController() {
        let userInfoVC = UIStoryboard(name: "Mine", bundle: nil).instantiateViewControllerWithIdentifier("WSUserInfoViewController")
        self.navigationController?.showViewController(userInfoVC, sender: nil)
    }
    
    //MARK: - tableview datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cellIdentifierArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellIdentifierArray[section].count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeightArray[indexPath.section][indexPath.row]
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = cellIdentifierArray[indexPath.section][indexPath.row]
        
        let  cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        if let myCell = cell as? WSTableViewCell {
            myCell.sepline.hidden = true

        }
        
        if let myCell = cell as? WSMineCustomCell {
            myCell.configCellWithData(dataSource[indexPath.section][indexPath.row])
        }
        if let myCell = cell as? WSMineOrderCell {
            myCell.configCellWithData(dataSource[indexPath.section][indexPath.row])
        }
        
        return cell
    }
    
}
