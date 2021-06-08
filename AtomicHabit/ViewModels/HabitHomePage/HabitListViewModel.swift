//
//  HabitListViewModel.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-16.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import Foundation
import Combine

class HabitListViewModel: ObservableObject {
    
    @Published var habitRepository = HabitRepository()
    @Published var habitCellViewModels = [HabitCellViewModel]()
    
    
    @Published var selectedHabit = HabitCellViewModel(habit: Habit())
    

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        habitRepository.$habits
            .map{ habits in
                habits.map { habit in
                  HabitCellViewModel(habit: habit)
            }
        }
            .assign(to: \.habitCellViewModels, on: self)
            .store(in: &cancellables)
        
        habitRepository.$selectedHabit
            .map{ habit in
                  HabitCellViewModel(habit: habit)
            }
            .assign(to: \.selectedHabit, on: self)
            .store(in: &cancellables)
    
    }
    

    
    func addHabbit(habit: Habit) {
        habitRepository.addHabit(habit: habit)
    }
    
    func updateHabit(habit: Habit) {
        habitRepository.updateHabit(habit)
    }
    
    func deletedHabit(habit: Habit) {
        habitRepository.deleteHabit(habit)
    }
    
}


