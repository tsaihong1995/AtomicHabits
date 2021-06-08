//
//  CommunityHabitsListViewModel.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-12.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase
import SwiftUI



class CommunityHabitsListViewModel: ObservableObject {
    
    @Published var habits = [Habit]()
    
    init() {
        
    }
    
    let db = Firestore.firestore()
    
    func loadHabitFromCategories(from category: String) {
        
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("habits")
            .whereField("category", isEqualTo: category)
            .whereField("userId", isNotEqualTo: userId as Any)
            .addSnapshotListener {(querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.habits = querySnapshot.documents.compactMap { document in
                        try? document.data(as: Habit.self)
                    }
                }
            }
    }
        
    
    
    func createComment(_ habit: Habit, comment: Comment){
        
        var addedComment = comment
        
        do {
            var ref: DocumentReference? = nil
            var commentRef: DocumentReference? = nil
            
            addedComment.commenterID = Auth.auth().currentUser?.uid
            addedComment.recieverID = habit.userId
            
            db.collection("users").document(Auth.auth().currentUser!.uid)
                .getDocument{ (document, error) in
                    if let document = document, document.exists {
                        
                        let userInfo = try? document.data(as: FBUser.self)
                        addedComment.commenterName = userInfo?.name
                        
                        
                            ref = try? self.db.collection("comments").addDocument(from: addedComment){ err in
                                if let err = err {
                                    print("Error adding document: \(err)")
                                } else {
                                    print("Comment Document added with ID: \(ref!.documentID)")
                                    commentRef = self.db.document("comments/\(ref!.documentID)")
                                    
                                    //After create the document in the firestore, update the original habits.
                                    do {
                                        self.db.collection("habits").document(habit.id!)
                                            .updateData([
                                                "comments": FieldValue.arrayUnion([commentRef as Any])
                                            ])
                                            { error in
                                                if let error = error {
                                                    print(error.localizedDescription)
                                                } else {
                                                    //load the docs and populate the items
                                                }
                                                
                                            }
                                        // Add the notification collection
                                        do {
                                            let addedNotification = Notification(sender: Auth.auth().currentUser?.uid ?? "UnknowID",
                                                                                 senderName: userInfo!.name,
                                                                                 reciever: habit.userId!,
                                                                                 habitTitle: habit.title)
                                            let _ = try self.db.collection("notifications").addDocument(from: addedNotification)
                                            print("Notification has been add")
                                        }
                                        catch {
                                            fatalError("Unable to encode habit: \(error.localizedDescription)")
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            print("Comments has been add")
                        
                    } else {
                        print("Document does not exist")
                    }
                    
                }

            
        }
        
        
        
    }
    
}
