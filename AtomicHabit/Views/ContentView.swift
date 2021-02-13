//
//  ContentView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-08.
//

import SwiftUI


// MARK: - This is dummy data for testing
let mockData = [
    Habit(title: "Sleep Early", goalCount: 5, currentCount: 0, achieve: false, description: "Sleep before 12:00 am everyday."),
    Habit(title: "Eat health", goalCount: 30, currentCount: 2, achieve: false, description: "Skip the fast food"),
    Habit(title: "Skip Social Media", goalCount: 5, currentCount: 2, achieve: false, description: "Before go to bed, do not use the social media")
]

// MARK: - PROPERTIES

struct ContentView: View {
    
    var tasks = mockData
    
    @ObservedObject private var viewModel = HabitViewModel()
    @ObservedObject private var editViewModel = HabitEditViewModel()
    @State private var presentScheduleHabitScreen: Bool = false
    @State private var isShowingDetailView: Bool = false
    
    
    var body: some View {
        NavigationView {
            List(viewModel.goals) { habit in
                
                HStack{
                    HabitRowView(habit: self.editViewModel.habit)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding(5)
                        .foregroundColor(Color.white)
                        .background(Color.purple)
                        .onTapGesture {
                            self.editViewModel.habit = habit
                            self.isShowingDetailView = true
                        }
                }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                
            }
            .background(
                NavigationLink(destination: HabitDetailView(habit: self.editViewModel.habit), isActive: $isShowingDetailView) {
                EmptyView()}
                .hidden())
            .listStyle(GroupedListStyle())
            .navigationBarTitle("My Goals")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {presentScheduleHabitScreen.toggle()}, label: {
                        Text("Schedule")
                    })
                }
            }
            .sheet(isPresented: $presentScheduleHabitScreen) {
                HabitScheduleView()
            }
            .onAppear() {
                self.viewModel.fetchData()
            }
            
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HabitRowView: View {
    
    @State var habit: Habit
    
    var body: some View {
        
        VStack(alignment: .leading) {
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
            Stepper(value: $habit.currentCount, in: 0...100) {
                // SwiftUI implicitly uses an HStack here
                Image(systemName: "circle.lefthalf.fill")
                Text(" \(habit.currentCount)/100")
            }
        }
    }
}
