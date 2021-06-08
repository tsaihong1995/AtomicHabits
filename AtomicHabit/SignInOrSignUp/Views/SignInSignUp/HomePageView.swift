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
    @State private var showOnBoarding = false
    @AppStorage("ObboardBeenViewed") var hasOnboarded = false
    
    var body: some View {
        ZStack{
            Group {
                if userInfo.isUserAuthenticated == .undefined {
                    EmptyView()
                } else if userInfo.isUserAuthenticated == .signedOut {
                    LoginView()
                } else {
                    MainTabScene()
                }
            }
            .disabled(showOnBoarding)
            .blur(radius: showOnBoarding ? /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/ : 0)
            if showOnBoarding {
                Onboarding(isPresenting: $showOnBoarding)
            }

        }
        .onAppear {
            self.userInfo.configureFirebaseStateDidChange()
            if !hasOnboarded {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        showOnBoarding.toggle()
                        hasOnboarded = true
                    }
                }
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView().environmentObject(UserInfo())
    }
}
