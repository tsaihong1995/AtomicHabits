//
//  AtomicHabit.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-13.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

let mockData2 = [
    AtomicHabit(title: "Sleep Early", goalCount: 5, currentCount: 0, achieve: false, description: "Sleep before 12:00 am everyday."),
    AtomicHabit(title: "Eat health", goalCount: 30, currentCount: 2, achieve: false, description: "Skip the fast food"),
    AtomicHabit(title: "Skip Social Media", goalCount: 5, currentCount: 2, achieve: false, description: "Before go to bed, do not use the social media")
]

struct AtomicHabit: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var goalCount: Int
    var currentCount: Int
    var achieve: Bool
    var description: String

  
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case goalCount = "totalCount"
        case currentCount = "eventCount"
        case achieve
        case description
    }
}
