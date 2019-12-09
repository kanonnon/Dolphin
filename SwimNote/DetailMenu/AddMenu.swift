//
//  AddMenu.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/08/25.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit

class AddMenu: NSObject {
    
        var memuName: String?
        var style: String?
        var detail: String?
        var memo: String?
        var distance: String?
        var times: String?
        var sets: String?
        var totalLength: String?
        var circle: String?
        var setRest: String?
        var time: String?
    
    init(menuName: String, style: String, detail: String, memo: String, distance: String, times: String, sets: String, totalLength: String, circle: String, setRest: String, time: String) {
         self.memuName = menuName
         self.style = style
         self.detail = detail
         self.memo = memo
         self.distance = distance
         self.times = times
         self.sets = sets
         self.totalLength = totalLength
         self.circle = circle
         self.setRest = setRest
         self.time = time
    }

}
