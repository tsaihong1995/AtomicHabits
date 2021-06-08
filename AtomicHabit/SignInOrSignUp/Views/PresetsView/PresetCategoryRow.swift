//
//  PresetCategoryRow.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-05.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct PresetCategoryRow: View {
    
    @Environment (\.presentationMode) var presentationMode
    var categoryName: String
    var items: [HabitPreset]
    @Binding var selectedPreset: HabitPreset
    
    var body: some View {
        let cols = [GridItem(.adaptive(minimum: 100, maximum: 200))]
        
        VStack(alignment: .leading){
            Text(categoryName)
                        .font(.headline)
                        .padding(.leading, 15)
                        .padding(.top, 5)
            
                LazyVGrid(columns: cols) {
                    ForEach(items, id: \.self) { presetsHabit in
                        PresetHabitItem(iconPic: presetsHabit.iconPic, iconDescription: presetsHabit.title)
                            .onTapGesture {
                                print("Preset:\(presetsHabit.title) has been press")
                                self.selectedPreset = presetsHabit
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            
                    }
                    
                }
                .padding(.horizontal)
            }
    }
}

