//
//  ProfileViewModel.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-04-01.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase
import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var notifications = [Notification]()
    @Published var habit = Habit()
    
    init() {
        loadNotifications()
    }
    
    let db = Firestore.firestore()
    

    func loadNotifications() {
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("notifications")
            .whereField("reciever", isEqualTo: userId as Any)
            .addSnapshotListener {(querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.notifications = querySnapshot.documents.compactMap { document in
                        try? document.data(as: Notification.self)
                    }
                }
            }
    }
    
    
    func fetchHabitName(_ habitID: String, completion: (_ success: Bool) -> Void){
        
         db.collection("habits").document(habitID)
            .getDocument { (document, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                } else {
                    if let document = document {
                        print("Document data: \(String(describing: document.data()))")
                        self.habit = try! document.data(as: Habit.self)!
                    
                    }
                }
            }
        
        completion(true)
        
    }
    
    
    
}
