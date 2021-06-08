//
//  HomeView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-17.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        NavigationView {
            Text("Logged in as \(userInfo.user.name).")
                .navigationBarTitle("Firebase Login")
                .navigationBarItems(trailing: Button("Log Out") {
                    FBAuth.logout { (result) in
                        print("Logged out")
                    }
                })
                .onAppear {
                    
                    #if DEBUG
                    
                    #else
                    guard let uid = Auth.auth().currentUser?.uid else {
                        return
                    }
                    FBFirestore.retrieveFBUser(uid: uid) { (result) in
                        switch result {
                        case .failure(let error):
                            print(error.localizedDescription)
                            //Display the alert to the user.
                        case .success(let user):
                            self.userInfo.user = user
                        }
                    }
                    #endif
                    

                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        HomeView()
            .environmentObject(UserInfo())

        
    }
}

