//
//  WSChatRegister.swift
//  WalkShopper
//
//  Created by dulingkang on 16/1/9.
//  Copyright © 2016年 Ding Yi. All rights reserved.
//

import Foundation

let isRegisteredKey = "isResigtered"

class WSChatRegister: NSObject {
    
    override init() {}
    static func autoRegister(userName: String) {
        if EaseMob.sharedInstance().chatManager.isLoggedIn {
            return
        }
        if userName.isEmpty {
            return
        }
        var isRegistered = NSUserDefaults.standardUserDefaults().boolForKey(isRegisteredKey)
        if !isRegistered {
            EaseMob.sharedInstance().chatManager.asyncRegisterNewAccount(userName, password: userName, withCompletion: { (name, passwd, error) -> Void in
                if error == nil {
                    isRegistered = true
                    print("chat register success")
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: isRegisteredKey)
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                }, onQueue: nil)
        }
        
        EaseMob.sharedInstance().chatManager.asyncLoginWithUsername(userName, password: userName, completion: { (loginInfo, error) -> Void in
            if error != nil {
                EaseMob.sharedInstance().chatManager.enableAutoLogin!()
                print("chat login success")
            }
            }, onQueue: nil)
    }
}