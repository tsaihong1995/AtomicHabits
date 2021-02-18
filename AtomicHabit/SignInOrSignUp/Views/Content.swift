//
//  HomePageView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-17.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct HomePageView: View {
    
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        Group {
            if userInfo.isUserAuthenticated == .undefined {
                Text("Loading...")
            } else if userInfo.isUserAuthenticated == .signedOut {
                LoginView()
            } else {
                HomeView()
            }
        }
        .onAppear {
            self.userInfo.configureFirebaseStateDidChange()
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
