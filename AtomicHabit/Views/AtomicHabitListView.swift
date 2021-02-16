//
//  AtomicHabitListView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-13.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI


struct StepperDetail: View {
    
    @State var habit: AtomicHabit
    @StateObject var viewModel = AtomicHabitViewModel()

    var body: some View {
        Stepper(
            onIncrement: {
                onIncreaseEvent()},
            onDecrement: {
                onDecreaseEvent()},
            label: {
                Image(systemName: "circle.lefthalf.fill")
                Text(" \(habit.currentCount)/\(habit.goalCount)")
            })
    }
    
    func onIncreaseEvent(){
        self.habit.currentCount += 1
        viewModel.updateHabit(habit)
    }
    func onDecreaseEvent(){
        self.habit.currentCount -= 1
        viewModel.updateHabit(habit)
    }
}

struct AtomicHabitListView: View {
    
    
    //By using the @ObservedObject property wrapper (1), we tell SwiftUI to subscribe to the view model and invalidate (and re-render) the view whenever the observed object changes.
    @StateObject var viewModel = AtomicHabitsViewModel()

    @State private var presentScheduleHabitScreen: Bool = false
    @State private var isShowingDetailView: Bool = false
    @State var eventCount: Int = 0
        
    var body: some View {
        NavigationView {
            List(viewModel.habits) { habit in
                HStack{
                    VStack(alignment: .leading) {
                        AtomicHabitRowViewTest(habit: habit)
                        StepperDetail(habit: habit)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding(5)
                        .foregroundColor(Color.white)
                        .background(Color.purple)
                        .onTapGesture {
                            self.viewModel.selectedHabit(habit)
                            self.isShowingDetailView = true
                        }
                }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                
            }
            .onAppear() {
                print("AtomicHabitListView appears. Subscribing to data updates.")
                self.viewModel.subscribe()
            }
            .onDisappear() {
              // By unsubscribing from the view model, we prevent updates coming in from
              // Firestore to be reflected in the UI. Since we do want to receive updates
              // when the user is on any of the child screens, we keep the subscription active!
              //
              // print("BooksListView disappears. Unsubscribing from data updates.")
              // self.viewModel.unsubscribe()
            }
            .background(
                NavigationLink(destination: AtomicHabitDetailView(habit: self.viewModel.selectedHabit), isActive: $isShowingDetailView) {
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
                AtomicHabitEditView()
            }

        }
    }
    
    private func AtomicHabitRowViewTest(habit: AtomicHabit) -> some View {
        Group{
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
        }
    }
}

struct AtomicHabitListView_Previews: PreviewProvider {
    static var previews: some View {
        AtomicHabitListView()
    }
}
