//
//  HabitDetailEditView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-25.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct HabitDetailEditView: View {
    
    // MARK: - PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedHabit: Habit
    @ObservedObject var habitRepo = HabitRepository()
    @State var habitToUpdate = Habit()
    
    @State var selectedHabitPeriod: String = ""
    @State var numberFormatter: String = "1"
    

    var body: some View {
        NavigationView {
            VStack{
                Form {
                     Section(header: Text("Habit's Name")) {
                        HStack {
                            TextField("Name your Habit", text: $selectedHabit.title)
                        }
                         
                     }
                     Section(header: Text("Frequency & Unit")) {
                        Picker("", selection: $selectedHabitPeriod) {
                                Text("Day").tag("Day")
                                Text("Week").tag("Week")
                                Text("Month").tag("Month")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        HStack {
                            Text("Unit:")
                            Spacer()
                            TextField("Unit", text: $selectedHabit.unitDescription)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: false)
                        }
                        
                             HStack {
                                 TextField("Total time", text: $numberFormatter)
                                     .keyboardType(UIKeyboardType.decimalPad) // Show keyboard for phone numbers
                                     .textFieldStyle(PlainTextFieldStyle())
                                     .padding(.horizontal)
                                 Text("\(selectedHabit.unitDescription) per \(selectedHabitPeriod.description)")
                             }
                         
                     }
                    
                    Section() {
                        Picker("Category", selection: $selectedHabit.category) {
                                    ForEach(Habit.Category.allCases, id: \.self) { value in
                                        Text(value.localizedName)
                                            .tag(value)
                                    }
                                  }
                    }

                     Section(header: Text("Give some description for yourself")) {
                         TextField("Write some words to motivate yourself!", text: $selectedHabit.description)
                     }
                    

                    
                }
                
            }
            .navigationBarTitle("Edit Habit", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {CancelHasTapped()}, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: {DoneHasTapped()}, label: {
                    Text("Done")
                }))
            
      }
        .onAppear{
            InitScene()
        }
    }
    
    func InitScene() {
        selectedHabitPeriod = selectedHabit.period.rawValue
        numberFormatter = selectedHabit.goalCount.description
    }
    
    
    func CancelHasTapped() {
        dismiss()
    }
    
    func recordUserNumberInput(){
        selectedHabit.goalCount = Int(numberFormatter) ?? 1
    }
    
    func DoneHasTapped() {
        recordUserNumberInput()
        selectedHabit.period = Habit.Peroid(rawValue: selectedHabitPeriod) ?? Habit.Peroid.day
        habitRepo.updateHabit(selectedHabit)
        print("Updated")
        dismiss()
    }
    func dismiss() {
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct HabitDetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailEditView(selectedHabit: .constant(mockData1[1]))
    }
}
