//
//  PresetHabitItem.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-09.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct PresetHabitItem: View {
    @State var iconPic: String
    @State var iconDescription: String
    var body: some View {
        
        RoundedRectangle(cornerRadius: 25)
            .frame(width: 110, height: 100)
            .overlay(
                VStack(spacing: 5) {
                    Image("\(iconPic)")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .scaledToFit()
                        .frame(width: 50, height: 50,alignment: .center)
            
                        
                Text(iconDescription)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .font(Font.system(size: 14))
                    
                }
            )
            .padding(.horizontal, 5)
    }
}

struct PresetHabitItem_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            PresetHabitItem(iconPic: "habit-012-laundry", iconDescription: "Description")
                .previewLayout(.sizeThatFits)
                .padding()
            PresetHabitItem(iconPic: "habit-012-laundry", iconDescription: "Description")
                .previewLayout(.sizeThatFits)
                .padding()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
        
    }
}
