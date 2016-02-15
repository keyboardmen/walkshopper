//
//  WSMineViewController.swift
//  WalkShopper
//
//  Created by dulingkang on 16/2/3.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

import UIKit

class WSMineViewController: UIViewController, WSMineHeaderViewDelegate {

    @IBOutlet weak var headerView: WSMineHeaderView!
        
    override func viewDidLoad() {
        headerView.headerViewDelegate = self
    }
    
    //MARK: - header view delegate
    func showUserInfoViewController() {
        let userInfoVC = UIStoryboard(name: "Mine", bundle: nil).instantiateViewControllerWithIdentifier("WSUserInfoViewController")
        self.navigationController?.showViewController(userInfoVC, sender: nil)
    }
}
