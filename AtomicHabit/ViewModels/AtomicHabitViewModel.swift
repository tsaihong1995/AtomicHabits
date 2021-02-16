//
//  AtomicHabitViewModel.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-13.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore

class AtomicHabitViewModel: ObservableObject {
    // MARK: - Public properties
    
    @Published var habit: AtomicHabit
    @Published var modified = false
    
    // MARK: - Internal properties
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructors
    
    init(habit: AtomicHabit = AtomicHabit(title: "", goalCount: 0, currentCount: 0, achieve: false, description: "")) {
        
        self.habit = habit

        self.$habit
        .dropFirst()
        .sink { [weak self] habit in
          self?.modified = true
        }
        .store(in: &self.cancellables)
        

    }
    
    // MARK: - Firestore
    
    private var db = Firestore.firestore()
    
    private func addHabit(_ habit: AtomicHabit) {
      do {
        let _ = try db.collection("goals").addDocument(from: habit)
      }
      catch {
        print(error)
      }
    }
    
    func updateHabit(_ habit: AtomicHabit) {
      if let documentId = habit.id {
        do {
          try db.collection("goals").document(documentId).setData(from: habit)
        }
        catch {
          print(error)
        }
      }
    }
        
    private func updateOrAddHabit() {
      if let _ = habit.id {
        self.updateHabit(self.habit)
      }
      else {
        addHabit(habit)
      }
    }
    
    func removeHabit(_ habit: AtomicHabit) {
      if let documentId = habit.id {
        db.collection("goals").document(documentId).delete { error in
          if let error = error {
            print(error.localizedDescription)
          }
        }
      }
    }

    
    // MARK: - Model management
    
    func save() {
        addHabit(self.habit)
    }
    
    // MARK: - UI handlers
    
    func handleUpdate() {
      self.updateOrAddHabit()
    }
    
    func handleDoneTapped() {
      self.save()
    }

}
