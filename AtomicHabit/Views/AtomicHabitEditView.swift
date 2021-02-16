//
//  AtomicHabitEditView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-13.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct AtomicHabitEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = AtomicHabitViewModel()
    @State var numberFormatter: String = "1"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Habit's Name")) {
                    TextField("Name your Habit", text: $viewModel.habit.title)
                }
                Section(header: Text("How many time?")) {
                    TextField("Total time", text: $numberFormatter)
                        .keyboardType(UIKeyboardType.phonePad) // Show keyboard for phone numbers
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    //Handle the Charater

                    // (5)
                }
                Section(header: Text("Give some description")) {
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
    
    func recordUserNumberInput(){
        viewModel.habit.goalCount = Int(numberFormatter) ?? 1
    }
    
    func DoneHasTapped() {
        recordUserNumberInput()
        viewModel.save()
        dismiss()
    }
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct AtomicHabitEditView_Previews: PreviewProvider {
    static var previews: some View {
        AtomicHabitEditView()
    }
}
