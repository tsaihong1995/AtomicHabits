//
//  CategoryGrid.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-16.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct CategoryGrid: View {
    
    @ObservedObject var communityListVM : CommunityHabitsListViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHGrid(rows: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
                Section() {
                    ForEach(Habit.Category.allCases, id: \.self) { category in
                        CategoryItemView(category: category, CommunityListVM: communityListVM)
                    }
                }
            }) //: GRID
            .frame(height: 100)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }) //: SCROLL
    }
}

struct CategoryItemView: View {
    // MARK: - PROPERTY
    
    let category: Habit.Category
    
    @ObservedObject var CommunityListVM : CommunityHabitsListViewModel
    
    
    // MARK: - BODY
    
    var body: some View {
        Button(action: {
            CommunityListVM.loadHabitFromCategories(from: category.rawValue)
        }, label: {
            HStack(alignment: .center, spacing: 10) {
                Spacer()
                
                Text(category.rawValue.uppercased())
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
                Spacer()
            } //: HSTACK
            .frame(width: 115, height: 10)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }) //: BUTTON
    }
}


struct CategoryGrid_Previews: PreviewProvider {
    static var previews: some View {
        let communityListVM = CommunityHabitsListViewModel()
        Group{
            CategoryGrid(communityListVM: communityListVM)
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
            CategoryGrid(communityListVM: communityListVM)
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
        
    }
}
