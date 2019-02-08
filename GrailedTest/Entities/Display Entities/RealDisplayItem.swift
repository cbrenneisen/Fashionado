//
//  RealDisplayItem.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/19/19.
//  Copyright © 2019 CarlBrenneisen. All rights reserved.
//

import Foundation

struct RealDisplayItem: DisplayItem {
    
    let type = DisplayType.real
    
    let title: String
    let date: String
    let image: String
    
    init?<T: Item>(item: T) {
        
        guard let date = Formatter.date(from: item) else {
            return nil
        }
        
        self.title = item.title
        self.image = ContentAPI.Image.url(for: item.image)

        self.date = Formatter.prettify(date: date)
    }
}

fileprivate struct Formatter {
    
    /**
        Convert a date from the server to the desired format
        - parameter date: The date from the server
        - returns: The same date, but prettified
    */
    static func prettify(date: Date) -> String {
        return writer.string(from: date)
    }
    
    static func date<T: Item>(from item: T) -> Date? {
        return reader.date(from: item.date)
    }
    
    /**
        A formatter that is used to read dates from the server
    */
    private static var reader: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        return dateFormatter
    }
    
    /**
        A formatter that is used to convert date objects to pretty strings
     */
    private static var writer: DateFormatter {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }
}
