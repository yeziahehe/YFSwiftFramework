//
//  NSFileManager+YFExtension.swift
//  YFSwiftFramework
//
//  Created by 叶帆 on 16/8/5.
//  Copyright © 2016年 Suzhou Coryphaei Information&Technology Co., Ltd. All rights reserved.
//

import Foundation

public extension NSFileManager {
    
    // MARK: Path
    /**
     缓存地址
     - returns: NSURL
     */
    public class func cachesURL() -> NSURL {
        return try! NSFileManager.defaultManager().URLForDirectory(.CachesDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
    }
    
    /**
     缓存地址
     - returns: String
     */
    public class func cacheURLStrng() -> String {
        return NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).first!
    }
    
    // MARK: Size
    /// 计算缓存大小
    public class func cachesSize() -> Float {
        let files = NSFileManager.defaultManager().subpathsAtPath(cacheURLStrng())
        var size: Float = 0
        
        for fileName in files!{
            let path = cacheURLStrng().stringByAppendingFormat("/\(fileName)")
            let floder = try! NSFileManager.defaultManager().attributesOfItemAtPath(path)
            
            for (abc, bcd) in floder {
                if abc == NSFileSize {
                    size += bcd.floatValue
                }
            }
        }
        return size/(1024*1024)
    }
    
    // MARK: Clean Caches
    /// 清除缓存
    public class func cleanCachesDirectoryAtURL(cachesDirectoryURL: NSURL) {
        let fileManager = NSFileManager.defaultManager()
        
        if let fileURLs = (try? fileManager.contentsOfDirectoryAtURL(cachesDirectoryURL, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions())) {
            for fileURL in fileURLs {
                do {
                    try fileManager.removeItemAtURL(fileURL)
                } catch _ {
                    yfLog.error("Clean Caches - removeItemAtURL: \(fileURL) error!")
                }
            }
        }
    }
}