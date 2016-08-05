//
//  AppDelegate+Extension.swift
//  YFSwiftFramework
//
//  Created by 叶帆 on 16/7/28.
//  Copyright © 2016年 Suzhou Coryphaei Information&Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyBeaver

let yfLog = SwiftyBeaver.self

let cacheDirectory: NSURL = {
    let urls = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)
    return urls[urls.endIndex - 1]
}()

extension AppDelegate {
    
    // MARK: Log Configure
    func configureYFLog() {
        
        //控制台输出
        let console = ConsoleDestination()
        console.coloredLines = true
        yfLog.addDestination(console)
        
        //文件输出
        let file = FileDestination()
        file.coloredLines = true
        file.logFileURL = cacheDirectory.URLByAppendingPathComponent(YFConfig.appName+".log")
        yfLog.addDestination(file)
    }
}
