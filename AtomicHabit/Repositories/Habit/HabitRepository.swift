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
    @Published var selectedHabit = Habit()
    
    
    @Published var habitPresets = [HabitPreset]()
    @Published var userHabitCount = 0
    @Published var comments = [Comment]()
    
    
    
    init() {
        loadData()
        loadHabitPresetsData()
    }
    
    
    func loadComment(habit: Habit){
        print("Load Comment")
        
        db.collection("comments")
            .whereField("habitID", isEqualTo: habit.id as Any)
            .addSnapshotListener{ (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.comments = querySnapshot.documents.compactMap { document in
                        try? document.data(as: Comment.self)
                    }
                }
        }
    }
    
    func loadData() {
        let userId = Auth.auth().currentUser?.uid
        db.collection("habits")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo: userId as Any)
            .addSnapshotListener {(querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.habits = querySnapshot.documents.compactMap { document in
                    try? document.data(as: Habit.self)
                }
            }
        }
    }
    

    
    func loadCount(){
        let userId = Auth.auth().currentUser?.uid
        db.collection("habits")
            .whereField("userId", isEqualTo: userId as Any)
            .getDocuments() { (querySnapshot,err) in

                if let err = err
                {
                    print("Error getting documents: \(err)");
                    return
                }
                else
                {
                    var count = 0
                    for document in querySnapshot!.documents {
                        count += 1
                        print("\(document.documentID) => \(document.data())");
                    }
                    self.userHabitCount = count
                    
                    print("Count = \(count)");
                    
                }
            }
    }
    
    
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
                
            var updatedHabit = habit
            
            if (habit.currentCount < habit.goalCount) {
                updatedHabit.achieve = false
            }
            else if (habit.currentCount >= habit.goalCount) {
                updatedHabit.achieve = true
            }
            
            
            do {
                try db.collection("habits").document(habitID).setData(from: updatedHabit)
            }
            catch {
                fatalError("Unable to encode habit: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteHabit(_ habit: Habit) {
        if let habitID = habit.id {
            db.collection("habits").document(habitID).delete()
            print("Habit has been deleted.")
        }
    }
}
