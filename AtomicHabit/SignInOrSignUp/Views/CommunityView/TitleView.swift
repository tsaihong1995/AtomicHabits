//
//  TitleView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-12.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

import SwiftUI

struct TitleView: View {
  // MARK: - PREVIEW
  
  var title: String
  
  // MARK: - BODY
  
  var body: some View {
    HStack {
      Text(title)
        .font(.title3)
        .fontWeight(.bold)
      
      Spacer()
    } //: HSTACK
    .padding(.horizontal)
    .padding(.top, 1)
    .padding(.bottom, 1)
  }
}

// MARK: - PREVIEW

struct TitleView_Previews: PreviewProvider {
  static var previews: some View {
    TitleView(title: "Select Category")
      .previewLayout(.sizeThatFits)
  }
}
