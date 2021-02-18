//
//  Habit.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-16.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore


let mockData1 = [
    Habit(title: "Sleep Early", goalCount: 5, currentCount: 0, achieve: false, description: "Sleep before 12:00 am everyday."),
    Habit(title: "Eat health", goalCount: 30, currentCount: 2, achieve: false, description: "Skip the fast food"),
    Habit(title: "Skip Social Media", goalCount: 5, currentCount: 2, achieve: false, description: "Before go to bed, do not use the social media")
]



struct Habit: Identifiable,Codable {
    @DocumentID var id: String?
    var title: String
    var goalCount: Int
    var currentCount: Int
    var achieve: Bool
    var description: String
    var userId: String?

    @ServerTimestamp var createdTime: Timestamp?
    
    init(title: String, goalCount: Int, currentCount: Int, achieve: Bool, description: String) {
        self.title = title
        self.goalCount = goalCount
        self.currentCount = currentCount
        self.achieve = achieve
        self.description = description
    }
    
    init() {
        self.title = "Default Title"
        self.goalCount = 1
        self.currentCount = 0
        self.achieve = false
        self.description = "Default Description"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case goalCount = "totalCount"
        case currentCount = "eventCount"
        case achieve
        case description
        case createdTime
        case userId
    }
}

