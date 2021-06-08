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
import SwiftUI



struct Habit: Identifiable,Codable, Hashable {
    @DocumentID var id: String?
    var title: String
    var goalCount: Int
    var currentCount: Int
    var achieve: Bool
    var description: String
    var userId: String?
    var unitDescription: String
    var category: Category
    var period: Peroid
    var comments: [DocumentReference]? = nil
    
    @ServerTimestamp var createdTime: Timestamp?
    
    init(title: String, goalCount: Int, currentCount: Int, achieve: Bool, description: String, unitDescription: String = "time(s)") {
        self.title = title
        self.goalCount = goalCount
        self.currentCount = currentCount
        self.achieve = achieve
        self.description = description
        self.category = Category.personalGrowth
        self.period = Peroid.day
        self.unitDescription = unitDescription
    }
    
    init() {
        self.title = ""
        self.goalCount = 1
        self.currentCount = 0
        self.achieve = false
        self.description = ""
        self.category = Habit.Category.personalGrowth
        self.period = Habit.Peroid.day
        self.unitDescription = "time(s)"
    }
    
    
    enum Peroid: String, CaseIterable, Codable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
    }
    
    enum Category: String, CaseIterable, Equatable, Codable {
        case health = "Health"
        case personalGrowth = "Personal Growth"
        case productive = "Productive"
        case dietImprove = "Diet Improve"
        case exercise = "Exercise"
        
        var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
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
        case comments
        case unitDescription
        case category
        case period
    }
}

