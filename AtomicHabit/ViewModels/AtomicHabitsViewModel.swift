//
//  AtomicHabitsViewModel.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-13.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import Foundation
import FirebaseFirestore

class AtomicHabitsViewModel: ObservableObject {
    
    @Published var habits = [AtomicHabit]()
    @Published var selectedHabit: AtomicHabit = AtomicHabit(title: "", goalCount: 0, currentCount: 0, achieve: false, description: "")
    
    private var listenerRegistration: ListenerRegistration?
    
    deinit {
      unsubscribe()
    }
    
    func unsubscribe() {
      if listenerRegistration != nil {
        listenerRegistration?.remove()
        listenerRegistration = nil
      }
    }
    
    func subscribe() {
      if listenerRegistration == nil {
        listenerRegistration = db.collection("goals").addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            print("No documents")
            return
          }
          
          self.habits = documents.compactMap { queryDocumentSnapshot in
            try? queryDocumentSnapshot.data(as: AtomicHabit.self)
          }
        }
      }
    }

    
    
    private var db = Firestore.firestore()
  
    func fetchData() {
        db.collection("goals").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents in the DB")
                return
            }
            self.habits = documents.compactMap{(queryDocumentSnapshot) -> AtomicHabit? in
                return try? queryDocumentSnapshot.data(as: AtomicHabit.self)
            }
            
        }
    }
    
    func selectedHabit(_ habit: AtomicHabit) {
        selectedHabit = habit
    }
}
