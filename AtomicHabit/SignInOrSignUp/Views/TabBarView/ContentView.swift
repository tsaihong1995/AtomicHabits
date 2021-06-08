//
//  ContentView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-15.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    @StateObject var viewRouter: ViewRouter
    @ObservedObject var communityVM = CommunityHabitsListViewModel()
    @ObservedObject var habitListVM = HabitListViewModel()
    @EnvironmentObject var userInfo: UserInfo
    @State var showPopUp = false
    @State var selectedPreset = HabitPreset()
    @State private var presentingAlert = false
    @State var userHabitCount = 0
    
    //@ObservedObject var habitListVM = HabitListViewModel()
    
    var alert =
        Alert(title: Text("Title"),
              message: Text("Message of the Alert"),
              primaryButton: .default(Text("Primary"), action: {
                // Primary Button code
              }),
              secondaryButton: Alert.Button.destructive(Text("Secondary"), action: {
                // Secondary Button code
              }))
        
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    switch viewRouter.currentPage {
                    case .home:
                        VStack(spacing: 10){
                            HabitListView(habitListVM: habitListVM)
                            Spacer()
                        }
                    case .community:
                        VStack(spacing: 10){
                            CommunityHome(communityVM: communityVM)
                            Spacer()
                        }
                    case .analyze:
                        VStack(spacing: 10){
                            Spacer()
                            Text("Analyze Page")
                            Spacer()
                        }
                    case .setting:
                            SettingView()
                    }
                    ZStack {
                        HStack {
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .community, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "heart", tabName: "Community")
                            ZStack {
                                Circle()
                                    .foregroundColor(.black)
                                    .frame(width: geometry.size.width/7.25, height: geometry.size.width/7.25)
                                    .shadow(radius: 1)
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width/7-6 , height: geometry.size.width/7-6)
                                    .foregroundColor(Color.white)

                            }
                                .offset(y: -geometry.size.height/8/2)
                                .onTapGesture {

//                                    if(habitListVM.habitCellViewModels.count < 3) {
                                        showPopUp.toggle()
//                                    }
//                                    else{
//                                        self.presentingAlert = true
//                                    }
                                }
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .analyze, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "waveform", tabName: "Analyze")
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .setting, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "gear", tabName: "Setting")
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color.gray.shadow(radius: 2))
                    }
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { FBAuth.logout { (result) in
                            print("Logged out")
                        }}, label: {
                            Text("Logout")
                        })
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .fullScreenCover(isPresented: $showPopUp) {
                    PresetHabitSchedule(selectedPreset: selectedPreset)
                }
                .alert(isPresented: $presentingAlert) {
                    Alert(title: Text("Oops..."),
                          message: Text("If you want add more than 3 Habits, please upgrade the account."),
                          dismissButton: .default(Text("Continue")))
                }
                .navigationTitle("Atomic Habit")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Press to dismiss") {
            presentationMode.wrappedValue.dismiss()
        }
        .font(.title)
        .padding()
        .background(Color.black)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(viewRouter: ViewRouter())
            .preferredColorScheme(.light)
    }
}

struct TabBarIcon: View {
    
    @StateObject var viewRouter: ViewRouter
    let assignedPage: Page
    
    let width, height: CGFloat
    let systemIconName, tabName: String

    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }
            .padding(.horizontal, -4)
            .onTapGesture {
                viewRouter.currentPage = assignedPage
            }
        .foregroundColor(viewRouter.currentPage == assignedPage ? Color.black : .white)
    }
}
