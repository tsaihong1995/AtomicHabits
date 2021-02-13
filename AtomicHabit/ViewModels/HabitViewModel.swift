//
//  GoalViewModel.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-09.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class HabitViewModel: ObservableObject {
    @Published var goals = [Habit]()
    
    private var db = Firestore.firestore()
    
    init() {
        self.$goals
            .map { goals in
                goals.map { goal in
                    
                    
                }
            }
    }
    
    
    
    
    func addGoal(goal: Habit) {
        do {
            //The collection here, we need to specific the collection in our Firestore.
            let _ = try db.collection("goals").addDocument(from: goal)
        }
        catch {
            print(error)
        }
    }
    
    func fetchData() {
        db.collection("goals").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents in the DB")
                return
            }
            self.goals = documents.compactMap{(queryDocumentSnapshot) -> Habit? in
                return try? queryDocumentSnapshot.data(as: Habit.self)
            }
            
        }
    }
}
