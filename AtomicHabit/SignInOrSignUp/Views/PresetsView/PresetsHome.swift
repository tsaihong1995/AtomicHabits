//
//  PresetsHome.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-16.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct PresetsHome: View {
    
    @ObservedObject private var viewModel = HabitPresetsViewModel()
    @Binding var selectedPreset: HabitPreset
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView{
                VStack{
                    Text("Select From Presets")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding(.vertical)
                    ForEach(viewModel.categories.keys.sorted(), id: \.self) { key in
                        PresetCategoryRow(categoryName: key, items: viewModel.categories[key]!, selectedPreset: $selectedPreset)
                    }
                }
            }
        .onAppear {
            viewModel.loadHabitPresetsData()
        }
        
        
    }
}
struct PresetsHome_Previews: PreviewProvider {
    static var previews: some View {
        PresetsHome(selectedPreset: .constant(mockPreset[1]))
    }
}
