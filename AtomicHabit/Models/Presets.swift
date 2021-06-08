//
//  Presets.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-02.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore


struct HabitPreset: Identifiable,Codable, Hashable {
    @DocumentID var id: String?
    var title: String
    var iconPic: String
    var category: Category
    var unitDescription: String
    
    

    init(title: String, iconPic: String, category: Category, unitDescription: String) {
        self.title = title
        self.iconPic = iconPic
        self.unitDescription = unitDescription
        self.category = category
    }
    
    
    //Default Preset
    init() {
        self.title = ""
        self.iconPic = "questionmark.circle"
        self.unitDescription = "times"
        self.category = HabitPreset.Category.personalGrowth
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case iconPic
        case category
        case unitDescription
        
    }
    
    enum Category: String, CaseIterable, Equatable, Codable {
        case health = "Health"
        case personalGrowth = "Personal Growth"
        case productive = "Productive"
        case dietImprove = "Diet Improve"
        case exercise = "Exercise"
        
        var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    }
    
}


let mockPreset = [
    HabitPreset(title: "Drink Water", iconPic: "habit-012-laundry", category: HabitPreset.Category.health, unitDescription: "Liter"),
    HabitPreset(title: "Jump Rope", iconPic: "habit-012-laundry", category: HabitPreset.Category.personalGrowth, unitDescription: "minute"),
    HabitPreset(title: "Wake Up", iconPic: "habit-012-laundry", category: HabitPreset.Category.health, unitDescription: "o'clock"),
    HabitPreset(title: "Laundry", iconPic: "habit-012-laundry", category: HabitPreset.Category.health, unitDescription: "time(s)"),
    HabitPreset(title: "Clean House", iconPic: "habit-008-housekeeping", category: HabitPreset.Category.personalGrowth, unitDescription: "time(s)"),
    HabitPreset(title: "Painting", iconPic: "habit-019-painting", category: HabitPreset.Category.personalGrowth, unitDescription: "time(s)"),
    HabitPreset(title: "Gardening", iconPic: "habit-033-gardening", category: HabitPreset.Category.personalGrowth, unitDescription: "time(s)"),
    HabitPreset(title: "Kniting", iconPic: "habit-035-knitting", category: HabitPreset.Category.personalGrowth, unitDescription: "hours"),
    HabitPreset(title: "Meditation", iconPic: "habit-036-yoga", category: HabitPreset.Category.personalGrowth, unitDescription: "hours"),
    HabitPreset(title: "Swimming", iconPic: "habit-031-swimming", category: HabitPreset.Category.personalGrowth, unitDescription: "ho1urs")
]

