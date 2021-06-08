//
//  HabitPresetsViewModel.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-06.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class HabitPresetsViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var habitRepository = HabitRepository()
    @Published var habitPresets = [HabitPreset]()
    
    var categories: [String: [HabitPreset]] {
        Dictionary(
            grouping: self.habitPresets,
            by: { $0.category.rawValue }
        )
    }
        
    var id = ""

    func loadHabitPresetsData() {
        db.collection("habitPresets")
            .addSnapshotListener {(querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.habitPresets = querySnapshot.documents.compactMap { document in
                    try? document.data(as: HabitPreset.self)
                }
            }
        }
    }
    
}
