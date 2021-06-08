//
//  PresetSchedule.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-16.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct PresetHabitSchedule: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var presentingSheet = false
    @State var selectedPreset: HabitPreset
    @State var habitToAdd = Habit()
    @State var numberFormatter: String = "1"
    @State var peroidSelection = "Day"
    @StateObject var habitRepo = HabitRepository()
    @State var presentingAlert = false

    var body: some View {
        NavigationView {
            Form {
                 Section(header: Text("Habit's Name")) {
                    HStack {
                        TextField("Name your Habit", text: $selectedPreset.title)
                        
                        Button(action: {
                            self.presentingSheet = true
                        }) {
                            Image(systemName: "magnifyingglass")
                            Text("Presets")
                                .padding(.horizontal)
                        }
                        .padding(.vertical, 5)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .cornerRadius(10)
                        .sheet(isPresented: $presentingSheet) {
                            PresetsHome(selectedPreset: $selectedPreset)
                        }
                    }
                     
                 }
                 Section(header: Text("Frequency & Unit")) {
                        Picker("", selection: $peroidSelection) {
                            Text("Day").tag("Day")
                            Text("Week").tag("Week")
                            Text("Month").tag("Month")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    TextField("Unit", text: $selectedPreset.unitDescription)
                         HStack {
                             TextField("Total time", text: $numberFormatter)
                                 .keyboardType(UIKeyboardType.decimalPad) // Show keyboard for phone numbers
                                 .textFieldStyle(PlainTextFieldStyle())
                                 .padding(.horizontal)
                             Text("\(selectedPreset.unitDescription) per \(peroidSelection.description)")
                         }
                     
                 }
                
                Section() {
                    Picker("Category", selection: $selectedPreset.category) {
                                ForEach(HabitPreset.Category.allCases, id: \.self) { value in
                                    Text(value.localizedName)
                                        .tag(value)
                                }
                              }
                }

                 Section(header: Text("Give some description for yourself")) {
                     TextField("Write some words to motivate yourself!", text: $habitToAdd.description)
                        .keyboardType(UIKeyboardType.default)
                 }
            }
            .navigationBarTitle("Schedule Habit", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {CancelHasTapped()}, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: {DoneHasTapped(selectedPreset)}, label: {
                    Text("Done")
                }))
        }
        .alert(isPresented: $presentingAlert, content: {
            Alert(title: Text("Title Invalid"),
                  message: Text("Please name your habit"),
                  dismissButton: Alert.Button.default(Text("OK")))
        })
    }
    
    
    func CancelHasTapped() {
        dismiss()
    }
    
    func recordUserNumberInput(){
        habitToAdd.goalCount = Int(numberFormatter) ?? 1
    }
    
    func checkTitle(title: String) -> Bool {
        if(title != "") {
            return true
        }
        else {
            print("Please name your habit.")
            self.presentingAlert = true
            return false
        }
    }
    
    func DoneHasTapped(_ habit: HabitPreset) {
        
        if(checkTitle(title: selectedPreset.title)){
            recordUserNumberInput()
            habitToAdd.title = selectedPreset.title
            habitToAdd.category = Habit.Category(rawValue: selectedPreset.category.rawValue) ?? Habit.Category.personalGrowth
            habitToAdd.period = Habit.Peroid(rawValue: peroidSelection) ?? Habit.Peroid.day
            if(habitToAdd.description == "") {
                habitToAdd.description = "Didn't leave any description"
            }
            else{
            }
            habitToAdd.unitDescription = selectedPreset.unitDescription
            habitRepo.addHabit(habit: habitToAdd)
            dismiss()
        }
        else {
            
        }
    }
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}



struct PresetSchedule_Previews: PreviewProvider {
    static var previews: some View {
        PresetHabitSchedule(selectedPreset: mockPreset[1])
    }
}
