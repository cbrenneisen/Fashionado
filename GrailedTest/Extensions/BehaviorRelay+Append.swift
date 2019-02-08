//
//  BehaviorRelay.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/18/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import Foundation
import RxCocoa

extension BehaviorRelay {
    
    func append<T>(_ items: [T]) where Element == [T] {
        var values = value
        values.append(contentsOf: items)
        accept(values)
    }
}
