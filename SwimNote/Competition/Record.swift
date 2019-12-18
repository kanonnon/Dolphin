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
    
    var id: String?
    var name: String?
    var style: String?
    var length: String?
    var totalTime: String?
    var date: String?
    var competition: String?
    var place: String?
    var poolType: String?
    var reactionTime: String?
    var firstTime: String?
    var firstRap: String?
    var secondTime: String?
    var secondRap: String?
    var thirdTime: String?
    var thridRap: String?
    var fourthTime: String?
    var sense: String?
    var motivation: String?
    var physicalCondition: String?
    var memo: String?
    
    enum field: String {
        case id = "id"
        case name = "name"
        case style = "style"
        case length = "length"
        case totalTime = "totalTime"
        case date = "date"
        case competitoin = "competition"
        case place = "place"
        case poolType = "poolType"
        case reactionTime = "reactionTime"
        case firstTime = "firstTime"
        case firstRap = "firstRap"
        case secondTime = "secondTime"
        case secondRap = "secondRap"
        case thirdTime = "thirdTime"
        case thridRap = "thridRap"
        case fourthTime = "fourthTime"
        case sense = "sense"
        case motivation = "motivetion"
        case physicalCondition = "physicalCondition"
        case memo = "memo"
    }
}
    




