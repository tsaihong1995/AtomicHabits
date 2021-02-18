//
//  HabitScheduleView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-16.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct HabitScheduleView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = HabitListViewModel()
    @State var habitToAdd = Habit(title: "", goalCount: 1, currentCount: 0, achieve: false, description: "")
    @State var numberFormatter: String = "1"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Habit's Name")) {
                    TextField("Name your Habit", text: $habitToAdd.title)
                }
                Section(header: Text("How many time?")) {
                    TextField("Total time", text: $numberFormatter)
                        .keyboardType(UIKeyboardType.phonePad) // Show keyboard for phone numbers
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                Section(header: Text("Give some description")) {
                    TextField("Write some words to motivate yourself!", text: $habitToAdd.description)
                }
            }
            .navigationBarTitle("Add Habit", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {CancelHasTapped()}, label: {
                        Text("Cancel")
                    }),
                trailing: Button(action: {DoneHasTapped()}, label: {
                    Text("Done")
                })
            )
        }
    }
    
    func CancelHasTapped() {
        dismiss()
    }
    
    func recordUserNumberInput(){
        habitToAdd.goalCount = Int(numberFormatter) ?? 1
    }
    
    func DoneHasTapped() {
        recordUserNumberInput()
        viewModel.addHabbit(habit: habitToAdd)
        dismiss()
    }
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct HabitScheduleView_Previews: PreviewProvider {
    
    
    
    var habit: Habit
    
    static var previews: some View {
        
        HabitScheduleView()
    }
}
