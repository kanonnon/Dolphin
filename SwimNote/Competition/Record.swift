//
//  Record.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/09/13.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit
/// 試合の記録
class Record: NSObject {
    
    var style: String?
    var length: String?
    var totalTime: String?
    var date: String?
    var competition: String?
    var place: String?
    var poolType: String?
    var firstTime: String?
    var secondTime: String?
    var thirdTime: String?
    var fourthTime: String?
    var sense: String?
    var motivation: String?
    var physicalCondition: String?
    var firstRival: String?
    var firstRivalTime: String?
    var secondRival: String?
    var secondRivalTime: String?
    
    enum field: String {
        case style = "style"
        case length = "length"
        case totalTime = "totalTime"
        case date = "date"
        case competitoin = "competition"
        case place = "place"
        case poolType = "poolType"
        case firstTime = "firstTime"
        case secondTime = "secondTime"
        case thirdTime = "thirdTime"
        case fourthTime = "fourthTime"
        case sense = "sense"
        case motivation = "motivetion"
        case physicalCondition = "physicalCondition"
        case firstRival = "firstRival"
        case firstRivalTime = "firstRivalTime"
        case secondRival = "secondRival"
        case secondRivalTime = "secondRivalTime"
    }
}
    




