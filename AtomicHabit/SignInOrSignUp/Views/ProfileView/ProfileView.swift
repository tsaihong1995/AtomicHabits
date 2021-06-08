//
//  ProfileView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-31.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var userInfo: UserInfo
    @ObservedObject var profileVM = ProfileViewModel()
    @State var data = ["Swipe to Delete", "Practice Coding", "Grocery shopping", "Get tickets", "Clean house", "Do laundry", "Cook dinner", "Paint room"]
    
    
    var body: some View {
                
        VStack(){
            CircleImage()
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
            VStack(spacing: 15) {
                Section() {
                    HStack {
                        Text("Email")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Text(userInfo.user.email)
                    }
                    .padding(.horizontal)
                    Divider()
                    HStack {
                        Text("User Name")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Text(userInfo.user.name)
                    }
                    .padding(.horizontal)
                    Divider()
                    HStack {
                        Text("UID Number")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Text(userInfo.user.uid)
                    }
                    .padding(.horizontal)
                    Divider()
                    
                    TitleView(title: "Notification:")
                    List {
                        Section() {
                            ForEach(profileVM.notifications, id: \.self) { datum in
                                NotificationRowView(commenterName: datum.senderName,  habitName: datum.habitTitle)
                            }
                            .onDelete(perform: delete) // Enables swipe to delete
                        }
                    }

                }
                
                
            }
            .navigationBarTitle("Profile", displayMode: .inline)
            
            Spacer()
            
            
        }
        .environmentObject(userInfo)
        
    }
    
    func delete(at indexes: IndexSet) {
        if let first = indexes.first {
            data.remove(at: first)
            
        }
    }
}

// MARK: - CommentRowView
struct NotificationRowView: View {
    // MARK: - PROPERTIES
    
    var commenterName: String
    var habitName: String
    
    // MARK: - BODY
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image("Icon-51")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .cornerRadius(9)
                    .padding(.leading, 10)
                VStack(alignment: .leading) {
                    Text("\(commenterName) leave the comment on your '\(habitName)'")
                        .foregroundColor(.gray)
                        .font(.caption)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(-50)
                }
                .padding(.trailing)
            } //: HSTACK
            
        }
        
    }
}

struct CircleImage: View {
    var body: some View {
        Image("Icon-51")
            .resizable()
            .frame(width: 75, height: 75)
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 10)
    }
}

struct ProfileView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        
        Group {
            ProfileView()
                .environmentObject(UserInfo())
            ProfileView()
                .environmentObject(UserInfo())
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            CircleImage()
                .previewLayout(.sizeThatFits)
                .padding()
            NotificationRowView(commenterName: "Hung-Chun", habitName: "Run 5km")
                .previewLayout(.sizeThatFits)
                .padding()
            NotificationRowView(commenterName: "Hung-Chun", habitName: "Run 5km")
                .previewLayout(.sizeThatFits)
                .padding()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
        
    }
}

