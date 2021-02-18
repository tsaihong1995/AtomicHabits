//
//  HabitDetailView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-16.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct HabitDetailView: View {
    @ObservedObject var habitListVM = HabitListViewModel()
    @State var selectedHabit: Habit
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(selectedHabit.title)
                .font(.headline)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text("Description: \(selectedHabit.description)")
                .font(.subheadline)
            Text("Goal Count: \(selectedHabit.goalCount)")
                .font(.subheadline)
            Text("Current Count: \(selectedHabit.currentCount)")
                .font(.subheadline)
            Text("Achieve: \(selectedHabit.achieve.description)")
                .font(.subheadline)
            
            TextField("Name your Habit", text: $selectedHabit.title)
            
            
            Button(action: {
                DoneHasTapped(selectedHabit)
            }, label: {
                Text("Change the Value")
            })
            
            Button(action: {
                //DeleteHasTapped(selectedHabit)
            }, label: {
                Text("Delete the Task")
            })
        }
    }
    
    func DoneHasTapped(_ habit: Habit) {
        habitListVM.updateHabit(habit: habit)
        dismiss()
    }
    
//    func DeleteHasTapped(_ habit: Habit) {
//        habitViewModel.removeHabit(habit)
//        dismiss()
//    }
 
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(selectedHabit: mockData1[1])
    }
}
