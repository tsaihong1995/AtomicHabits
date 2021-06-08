//
//  LoginView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-17.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct LoginView: View {

    enum Action:Int, Identifiable {
        
        var id: Int {
            rawValue
        }
        
        case signUp, resetPW
    }
    
    @State private var showSheet = false
    @State private var action: Action?
    
    var body: some View {
        VStack {
            Image("Icon-51")
                .resizable()
                .scaledToFit()
                .frame(width: 100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100)
            Text("Atomic Habits")
            SignInWithEmailView(showSheet: $showSheet, action: $action)
            SignInWithAppleView().frame(width: 200, height: 50)
        }
        .sheet(item: $action) { actions in
            switch actions {
            case .signUp:
                SignUpView()
            case .resetPW:
                ForgotPasswordView()
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
