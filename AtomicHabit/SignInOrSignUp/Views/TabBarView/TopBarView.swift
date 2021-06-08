//
//  TopBarView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-28.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct TopBarView: View {
    
    var body: some View {
        HStack{
            NavigationLink(destination: ProfileView()) {
                Image(systemName: "person.circle")
                    .font(.system(size: 30, weight: .light))
                    .padding(.horizontal)
                    .foregroundColor(.blue)
                
            }
            Spacer()
            Text("Atomic Habit")
                .font(.title2)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Spacer()
            Button(action: { FBAuth.logout { (result) in
                print("Logged out")
            }}, label: {
                Text("Logout")
                    .foregroundColor(.red)
            })
            .padding(.horizontal)
        }
        .padding(.top)
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}
