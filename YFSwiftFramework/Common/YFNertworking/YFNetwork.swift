//
//  YFNetwork.swift
//  YFSwiftFramework
//
//  Created by 叶帆 on 16/8/8.
//  Copyright © 2016年 Suzhou Coryphaei Information&Technology Co., Ltd. All rights reserved.
//

import Foundation
import ReachabilitySwift
import Alamofire
import SwiftyJSON

// MARK: 网络状态
class YFNetworkMonitor {
    
    // MARK: 初始化
    static let sharedManager = YFNetworkMonitor()
    var reachability: Reachability?
    
    init() {
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
        } catch {
            yfLog.error("Unable to create Reachability")
        }
    }
    
    deinit {
        reachability?.stopNotifier()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ReachabilityChangedNotification, object: nil)
    }
    
    // MARK: 网络状态的启动和停止
    /// 启动网络监听
    func startMonitoring() {
        do {
            try reachability?.startNotifier()
        } catch {
            yfLog.error("reachability notifier 启动失败")
        }
    }
    
    /// 停止网络监听
    func stopMonitoring() {
        reachability?.stopNotifier()
    }
    
    // MARK: 网络状态改变
    @objc func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                yfLog.debug("Reachable via WiFi")
            } else {
                yfLog.debug("Reachable via Cellular")
            }
        } else {
            yfLog.debug("Network not reachable")
        }
    }
}
