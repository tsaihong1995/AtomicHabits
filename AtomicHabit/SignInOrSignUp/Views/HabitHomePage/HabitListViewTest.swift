////
////  HabitListView.swift
////  AtomicHabit
////
////  Created by Hung-Chun Tsai on 2021-02-16.
////  Copyright © 2021 CodeMonk. All rights reserved.
////
//
//import SwiftUI
//import Firebase
//
//struct HabitListViewTest: View {
//    @ObservedObject var habitListVM : HabitListVModel
//    
//    @EnvironmentObject var userInfo: UserInfo
//    
//    @State var presentHabitDetailScreen: Bool = false
//    @State var selectedPreset = HabitPreset()
//    
//    var body: some View {
//        NavigationView {
//            VStack{
//                TopBarView()
//                TitleView(title: "Your Habit:")
//                List {
//                    if(habitListVM.habits.isEmpty) {
//                        VStack{
//                            Spacer()
//                            Image("BlankPage")
//                                .resizable()
//                                .scaledToFit()
//                            Text("You don't have any habit\n Press the + Button to start journey!")
//                                .frame(maxWidth: 280)
//                                .multilineTextAlignment(.center)
//                                .font(.title3)
//                                .foregroundColor(.gray)
//                                .offset(y: -50)
//                            Spacer()
//                        }
//                        
//                    }
//                    else
//                    {
//                        
//                        ForEach(self.habitListVM.habits, id: \.self) { data in
//    
//                            GroupBox(
//                                label:
//                                    SettingLabelView(labelText: self.habitListVM.habitCellViewModels[index].habit.title, labelImage: "info.circle")
//                            ) {
//                                Text("\(habitListVM.selectedHabit.habit.title)")
//                                Divider().padding(.vertical, 4)
//                                HStack{
//                                    VStack(alignment: .leading) {
//                                        HabitCell(habitCellVM: self.habitListVM.habitCellViewModels[index])
//                                    }
//                                    Spacer()
//                                    NavigationLink(destination:
//                                                    HabitDetailView(habitCellVM: self.$habitListVM.habitCellViewModels[index], selectedHabit: self.habitListVM.habitCellViewModels[index].habit)
//                                    ) {
//                                        Image(systemName: "chevron.right")
//                                            .font(.system(size: 20, weight: .regular))
//                                            .padding(5)
//                                            .foregroundColor(Color.orange)
//                                    }
//                                }
//                            }
//                            
//                        }
//                    }
//                }
//                .listStyle(InsetListStyle())
//                .onAppear {
//                    #if DEBUG
//                    
//                    #else
//                    guard let uid = Auth.auth().currentUser?.uid else {
//                        return
//                    }
//                    FBFirestore.retrieveFBUser(uid: uid) { (result) in
//                        switch result {
//                        case .failure(let error):
//                            print(error.localizedDescription)
//                        //Display the alert to the user.
//                        case .success(let user):
//                            self.userInfo.user = user
//                        }
//                    }
//                    
//                    #endif
//                    
//                }
//            }//: VStack
//            
//            .navigationBarHidden(true)
//            
//            
//        }//: NavigationView
//    }
//}
//
//
//struct HabitListViewTest_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        
//        HabitListView(habitListVM: HabitListViewModel()).environmentObject(UserInfo())
//        
//    }
//}
