//
//  HabitCellViewModel.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-16.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import Foundation
import Combine

class HabitCellViewModel: ObservableObject, Identifiable {
    
    @Published var habitRepository = HabitRepository()
    @Published var habit: Habit
    
    var  id = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(habit: Habit) {
        self.habit = habit
        
        $habit
            .compactMap{ habit in
                habit.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $habit
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink{ habit in
                self.habitRepository.updateHabit(habit)
            }
            .store(in: &cancellables)
    }
    
}
