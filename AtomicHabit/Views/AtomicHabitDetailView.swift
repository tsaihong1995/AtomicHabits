//
//  AtomicHabitDetailView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-13.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct AtomicHabitDetailView: View {
    
    @State var habit: AtomicHabit
    @StateObject var habitViewModel = AtomicHabitViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(habit.id ?? "1")
            Text(habit.title)
                .font(.headline)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text("Description: \(habit.description)")
                .font(.subheadline)
            Text("Goal Count: \(habit.goalCount)")
                .font(.subheadline)
            Text("Current Count: \(habit.currentCount)")
                .font(.subheadline)
            Text("Stepper will be here")
                .font(.subheadline)
            Text("Achieve: \(habit.achieve.description)")
                .font(.subheadline)
            
            TextField("Name your Habit", text: $habit.title)
            
            
            Button(action: {
                DoneHasTapped(habit)
            }, label: {
                Text("Change the Value")
            })
            
            Button(action: {
                DeleteHasTapped(habit)
            }, label: {
                Text("Delete the Task")
            })
        }
    }
    
    func DoneHasTapped(_ habit: AtomicHabit) {
        habitViewModel.updateHabit(habit)
        dismiss()
    }
    
    func DeleteHasTapped(_ habit: AtomicHabit) {
        habitViewModel.removeHabit(habit)
        dismiss()
    }
 
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct AtomicHabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AtomicHabitDetailView(habit: mockData2[1])
    }
}
