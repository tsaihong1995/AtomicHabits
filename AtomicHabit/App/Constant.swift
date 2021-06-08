//
//  Constant.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-12.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

// LAYOUT

let columnSpacing: CGFloat = 10
let rowSpacing: CGFloat = 5
var gridLayout: [GridItem] {
  return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
}
