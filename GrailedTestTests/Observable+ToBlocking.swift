//
//  Observable+ToBlocking.swift
//  GrailedTestTests
//
//  Created by Cbrenneisen on 1/20/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import XCTest

extension Observable {
    
    /**
        A simple wrapper used to block and receive elements from an Observable.
        - parameter timeout: The max amount of time to wait. If this is exceeded, the current test will fail
        - returns: The events that occurred
    */
    func toBlockingArray(timeout: RxTimeInterval? = nil) -> [Element] {
        do {
            return try self.toBlocking(timeout: timeout).toArray()
        } catch {
            XCTFail(error.localizedDescription)
        }
        return []
    }
}
