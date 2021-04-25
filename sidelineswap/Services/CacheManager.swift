//
//  CacheManager.swift
//  sidelineswap
//
//  Created by Danesh Rajasolan on 2021-04-25.
//

import Foundation
import UIKit


class CacheManager {
    static let shared = CacheManager()
    
    let cache: NSCache<NSString, NSData>!
    
    private init() {
        self.cache = NSCache<NSString, NSData>()
        self.cache.totalCostLimit = 20 * 1000 * 1024
    }
    
    func retrieveData(for key: NSString) -> NSData? {
        guard let data = cache.object(forKey: key) else { return nil }
        return data
    }
    
    func addData(for key: NSString, with data: NSData) {
        cache.setObject(data, forKey: key)
    }
}
