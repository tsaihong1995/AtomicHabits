//
//  HabitEditView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-09.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct HabitScheduleView: View {
    
    // MARK: - PROPERTIES
    
    @StateObject var viewModel = HabitEditViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Habit's Name")) {
                    TextField("Name your Habit", text: $viewModel.habit.title)
                }
                Section(header: Text("How many time?")) {
                    TextField("Enter a number", value: $viewModel.habit.goalCount, formatter: NumberFormatter())
                }
                Section(header: Text("How many time?")) {
                    TextField("Write some words to motivate yourself!", text: $viewModel.habit.description)
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
    func DoneHasTapped() {
        viewModel.save()
        dismiss()
    }
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct HabitEditView_Previews: PreviewProvider {
    static var previews: some View {
        HabitScheduleView()
    }
}
