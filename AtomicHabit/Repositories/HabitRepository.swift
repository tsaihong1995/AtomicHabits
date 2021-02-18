//
//  HabitRepository.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-16.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class HabitRepository: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var habits = [Habit]()
    
    init() {
        loadData()
    }
    
    
    func loadData() {
        
        let userId = Auth.auth().currentUser?.uid
        db.collection("habits")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener {(querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.habits = querySnapshot.documents.compactMap { document in
                    try? document.data(as: Habit.self)
                }
            }
        }
    }
    
    func addHabit(habit: Habit) {
        do {
            var addedHabit = habit
            addedHabit.userId = Auth.auth().currentUser?.uid
            let _ = try db.collection("habits").addDocument(from: addedHabit)
            print("Habit has been add")
        }
        catch {
            fatalError("Unable to encode habit: \(error.localizedDescription)")
        }
    }
    
    func updateHabit(_ habit: Habit) {
        if let habitID = habit.id {
            do {
                try db.collection("habits").document(habitID).setData(from: habit)
            }
            catch {
                fatalError("Unable to encode habit: \(error.localizedDescription)")
            }
        }
    }
    
}
