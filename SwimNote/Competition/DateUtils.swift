//
//  Date.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2020/01/15.
//  Copyright © 2020 kanon. All rights reserved.
//

import UIKit

class DateUtils {
    class func dateFromString(string: String, format: String) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.date(from: string)!
    }

}
