//
//  HabitListView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-16.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI
import Firebase

struct HabitListView: View {
    @ObservedObject var habitListVM : HabitListViewModel
    @ObservedObject var habitListRepo = HabitRepository()
    
    
    @EnvironmentObject var userInfo: UserInfo
    
    @State var presentHabitDetailScreen: Bool = false
    @State var selectedPreset = HabitPreset()
    @State var presentingAlert = false
    @State var deletedHabitIndex = -1
    @State var habitBeDeleted = Habit()
    @State var comfirmDeleted : Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack{
                TopBarView()
                TitleView(title: "Your Habit:")
                if(habitListVM.habitCellViewModels.isEmpty) {
                    VStack{
                        Spacer()
                        Image("BlankPage")
                            .resizable()
                            .scaledToFit()
                            .offset(y: -100)
                        Text("You don't have any habit\n Press the + Button to start journey!")
                            .frame(maxWidth: 280)
                            .multilineTextAlignment(.center)
                            .font(.title3)
                            .foregroundColor(.gray)
                            .offset(y: -150)
                        Spacer()
                    }

                }
                else{
                    List(0..<self.habitListVM.habitCellViewModels.count, id: \.self) { index in
                        GroupBox(
                            label:
                                HStack{
                                    Text(self.habitListVM.habitCellViewModels[index].habit.title.uppercased())
                                      .fontWeight(.bold)
                                    Spacer()
                                    Button(action: {
                                        self.presentingAlert = true
                                        self.deletedHabitIndex = index
                                        self.habitBeDeleted = self.habitListVM.habitCellViewModels[index].habit
                                        print("DeletedHabitIndex: \(self.deletedHabitIndex)")
                                     }) {
                                         Image(systemName: "minus.circle").foregroundColor(.red)
                                     }
                                }
                        ) {
                            Text("\(habitListVM.selectedHabit.habit.title)")
                            Divider().padding(.vertical, 4)
                            HStack{
                                VStack(alignment: .leading) {
                                    HabitCell(habitCellVM: self.habitListVM.habitCellViewModels[index])
                                }
                                Spacer()
                                NavigationLink(destination:
                                                HabitDetailView(habitListVM: self.habitListVM, habitCellVM: self.$habitListVM.habitCellViewModels[index], selectedHabit: self.habitListVM.habitCellViewModels[index].habit)
                                ) {
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 20, weight: .regular))
                                        .padding(5)
                                        .foregroundColor(Color.orange)
                                }
                            }
                        }
                    }
                    .listStyle(InsetListStyle())
                }
            }//: VStack
            .frame(maxHeight: .infinity)
            .navigationBarHidden(true)
            .onAppear {
                #if DEBUG
                
                #else
//                guard let uid = Auth.auth().currentUser?.uid else {
//                    return
//                }
//                FBFirestore.retrieveFBUser(uid: uid) { (result) in
//                    switch result {
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    //Display the alert to the user.
//                    case .success(let user):
//                        self.userInfo.user = user
//                    }
//                }
                
                #endif
                
            }
            .alert(isPresented: $presentingAlert) {
                
                Alert(title: Text("Delete"),
                      message: Text("Are you sure you want to delete?"),
                      primaryButton: .destructive(Text("Delete"), action: {
                        DeletedHasTapped()
                      }),
                      secondaryButton: .cancel(Text("No"), action: {
                        
                      }))
            }
        }//: NavigationView
    }
    
    func createHabitIndex(_ habitIndex: Int){
        
    }
    
    func DeletedHasTapped() {
        self.habitListVM.habitCellViewModels.remove(at: deletedHabitIndex)
        self.habitListVM.deletedHabit(habit: self.habitBeDeleted)
    }

}

struct HabitCell: View {
    
    @ObservedObject var habitCellVM: HabitCellViewModel
    
    @State var stepperCount: Int = 0
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Description: \(habitCellVM.habit.description)")
                .font(.subheadline)
            Text("Goal Count: \(habitCellVM.habit.goalCount)")
                .font(.subheadline)
            Text("Current Count: \(habitCellVM.habit.currentCount)")
                .font(.subheadline)
            HStack{
                Text("Achieve:")
                    .font(.subheadline)
                Image(systemName: habitCellVM.habit.achieve ? "checkmark" : "xmark")
                    .foregroundColor(.pink)
                    .font(.subheadline)
            }
            
        }
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            HStack {
                Spacer()
                //Increment Button
                Button(action: {
                    habitCellVM.habit.currentCount = habitCellVM.increaseHabitEvent(habitCellVM.habit)
                    checkAcheivement(habit: habitCellVM.habit)
                }) {
                    Image(systemName: "plus")
                        .frame(width: 100, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                        .background(Color.orange)
                        .cornerRadius(8)

                }
                Spacer()
                //Minus Button
                Button(action: {
                    habitCellVM.habit.currentCount = habitCellVM.decreaseHabitEvent(habitCellVM.habit)
                    checkAcheivement(habit: habitCellVM.habit)
                }) {
                    Image(systemName: "minus")
                        .frame(width: 100, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                        .background(Color.orange)
                        .cornerRadius(8)

                }
                Spacer()
            }
            .padding(.top)
            
        }
        .onAppear{
            
        }
        
    }
    
    
    func checkAcheivement(habit: Habit) {
        if (habit.currentCount >= habit.goalCount){
            self.habitCellVM.habit.achieve = true
        }
        else {
            self.habitCellVM.habit.achieve = false
        }
    }
    
    
}

struct HabitListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        HabitListView(habitListVM: HabitListViewModel()).environmentObject(UserInfo())
        
    }
}
