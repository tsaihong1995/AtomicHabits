//
//  HabitListView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-16.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct HabitListView: View {
    @ObservedObject var habitListVM = HabitListViewModel()
    
    @State var presentScheduleHabit: Bool = false
    @State var presentHabitDetailScreen: Bool = false
    
    var body: some View {
     
        NavigationView {
            List {
                ForEach(habitListVM.habitCellViewModels) { habitCellVM in
                    HStack{
                        VStack(alignment: .leading) {
                            HabitCell(habitCellVM: habitCellVM)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .padding(5)
                            .foregroundColor(Color.white)
                            .background(Color.purple)
                            .onTapGesture {
                                self.habitListVM.selectedHabit = habitCellVM.habit
                                self.presentHabitDetailScreen = true
                            }
                    }
                    .border(Color.black)
                }
            }
            .navigationBarTitle("My Habit")
            .background(
                NavigationLink(destination: HabitDetailView(selectedHabit: self.habitListVM.selectedHabit), isActive: $presentHabitDetailScreen) {
                EmptyView()}
                .hidden())
            .listStyle(GroupedListStyle())
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {self.presentScheduleHabit.toggle()}, label: {
                        Text("Schedule")
                    })
                }
            }
            .sheet(isPresented: $presentScheduleHabit) {
                HabitScheduleView()
            }

        }
    }
}

struct HabitCell: View {
    
    @ObservedObject var habitCellVM: HabitCellViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(habitCellVM.habit.title)
                .font(.headline)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text("Description: \(habitCellVM.habit.description)")
                .font(.subheadline)
            Text("Goal Count: \(habitCellVM.habit.goalCount)")
                .font(.subheadline)
            Text("Current Count: \(habitCellVM.habit.currentCount)")
                .font(.subheadline)
            Stepper(value: $habitCellVM.habit.currentCount, in: 1...100) {
                Text("")
            }
            Text("Achieve: \(habitCellVM.habit.achieve.description)")
                .font(.subheadline)
        }
    }
}

struct HabitListView_Previews: PreviewProvider {
    static var previews: some View {
        HabitListView()
    }
}
