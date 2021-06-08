//
//  MainTabScene.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-20.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI
import Combine


class MainTabBarData: ObservableObject {

    /// This is the index of the item that fires a custom action
    let customActionteminidex: Int

    let objectWillChange = PassthroughSubject<MainTabBarData, Never>()

    var itemSelected: Int {
        didSet {
            if itemSelected == customActionteminidex {
                itemSelected = oldValue
                isCustomItemSelected = true
            }
            objectWillChange.send(self)
        }
    }

    // This is true when the user has selected the Item with the custom action
    var isCustomItemSelected: Bool = false

    init(initialIndex: Int = 1, customItemIndex: Int) {
        self.customActionteminidex = customItemIndex
        self.itemSelected = initialIndex
    }
}

struct MainTabScene: View {
    
    @ObservedObject private var tabData = MainTabBarData(initialIndex: 1, customItemIndex: 3)
    
    @ObservedObject var communityVM = CommunityHabitsListViewModel()
    
    @ObservedObject var habitListVM = HabitListViewModel()
    
    @State var selectedPreset = HabitPreset()
    
    @State private var isPresent = false
    
    
    var body: some View {
        
            ZStack{
                VStack{
                    TabView (selection: $tabData.itemSelected){
                        
                        // First Secection
                        HabitListView(habitListVM: habitListVM)
                        .tabItem {
                            Image(systemName: "homekit")
                            Text("Home")
                        }.tag(1)

                        CommunityHome(communityVM: communityVM)
                        .tabItem {
                            Image(systemName: "heart")
                            Text("Community")
                        }.tag(2)
                            
                        // Events
                        Text("Analyze Page")
                        .tabItem {
                            Text("")
                                .font(.title)
                        }
                        .tag(3)

                        // Events
                        AnalyzeChart()
                        .tabItem {
                            Image(systemName: "waveform")
                            Text("Analyze")
                        }.tag(4)
                            
                        SettingView()
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Setting")
                        }.tag(5)

                    }//: TABView
                    .accentColor(.blue)
                }
                VStack{

                    Spacer()
                    ZStack {
                        Circle()
                            .foregroundColor(.black)
                            .frame(width:50, height: 50)
                            .shadow(radius: 1)
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50 , height: 50)
                            .foregroundColor(Color.white)

                    }
                    .offset(y: -10.0)
                    .onTapGesture {
                        self.isPresent = true
                    }
                }//: VSTACK
                .ignoresSafeArea(.keyboard)
                .statusBar(hidden: true)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $isPresent, onDismiss: {
                print("Dismiss")
            }) {
                PresetHabitSchedule(selectedPreset: selectedPreset)
            }
            

            
        
    }
}

struct MainTabScene_Previews: PreviewProvider {
    static var previews: some View {
        MainTabScene()
    }
}
