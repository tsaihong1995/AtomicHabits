//
//  CommunityHome.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-16.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct CommunityHome: View {
    
    @ObservedObject var communityVM : CommunityHabitsListViewModel
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        NavigationView {
            VStack {
                TopBarView()
                TitleView(title: "Select Category:")
                CategoryGrid(communityListVM: communityVM)
                ZStack{
                    ScrollView{
                            TitleView(title: "Activity")
                            
                                // MARK: - SECTION 1
                                if(communityVM.habits.isEmpty) {
                                    VStack{
                                        Image("BlankPage")
                                            .resizable()
                                            .scaledToFit()
                                            .offset(y: -75)
                                        Text("To see how the other people work, please select 1 category.")
                                            .frame(maxWidth: 280)
                                            .multilineTextAlignment(.center)
                                            .font(.title3)
                                            .foregroundColor(.gray)
                                            .offset(y: -150)
                                        Spacer()
                                    }
                                }
                                else {
                                    
                                    ForEach(communityVM.habits) { habit in
                                        
                                        VStack(spacing:5) {
                                            GroupBox(
                                                label:
                                                    HabitLabelView(labelText: habit.title, labelImage: "info.circle")
                                            ) {
                                                Divider().padding(.vertical, 4)
                                                
                                                HStack(alignment: .center, spacing: 10) {
                                                    Image("Icon-51")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 80, height: 80)
                                                        .cornerRadius(9)
                                                    
                                                    Text(habit.description)
                                                        .font(.footnote)
                                                    Spacer()
                                                } //: HSTACK
                                            } //: GroupBox
                                            .padding(.horizontal)
                                            .padding(.vertical, 5)
                                            CommentTextField(habit: habit, communityVM: communityVM)
                                                .padding(.horizontal)
                                        }
                                        Divider()
                                        
             
                                    }
                                    
                                }
                        }//: List
                    if(!networkManager.networkStatus){
                        Text("Check Your Network Status")
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(Color.red)
                            .cornerRadius(25)
                            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                    }
                }
                
            } // VStack
            .navigationBarHidden(true)
        }//: Navigation View
        
        
        
    }
}

// MARK: - SettingsRowView
struct HabitLabelRowView: View {
 // MARK: - PROPERTIES
 
 var name: String
 var content: String? = nil
 var linkLabel: String? = nil
 var linkDestination: String? = nil

 // MARK: - BODY

 var body: some View {
   VStack {
     Divider().padding(.vertical, 4)
     
     HStack {
       Text(name).foregroundColor(Color.gray)
       Spacer()
       if (content != nil) {
         Text(content!)
       } else if (linkLabel != nil && linkDestination != nil) {
         Link(linkLabel!, destination: URL(string: "https://\(linkDestination!)")!)
         Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
       }
       else {
         EmptyView()
       }
     }
   }
 }
}



struct HabitLabelView: View {
 // MARK: - PROPERTIES
 
 var labelText: String
 var labelImage: String

 // MARK: - BODY

 var body: some View {
   HStack {
     Text(labelText.uppercased()).fontWeight(.bold)
     Spacer()
     Image(systemName: labelImage)
   }
 }
}


struct CommunityHome_Previews: PreviewProvider {
    static var previews: some View {
        CommunityHome(communityVM: CommunityHabitsListViewModel())
    }
}
