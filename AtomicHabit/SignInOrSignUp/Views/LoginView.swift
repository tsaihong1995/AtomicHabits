//
//  LoginView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-17.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct LoginView: View {

    enum Action {
        case signUp, resetPW
    }
    
    @State private var showSheet = false
    @State private var action: Action?
    
    var body: some View {
        VStack {
            SignInWithEmailView(showSheet: $showSheet, action: $action)
            SignInWithAppleView().frame(width: 200, height: 50)
        }
            .sheet(isPresented: $showSheet) {
                if action == .signUp {
                    SignUpView()
                } else {
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
