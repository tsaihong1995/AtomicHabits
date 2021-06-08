//
//  ViewRouter.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-15.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import Foundation
import SwiftUI

enum Page {
     case home
     case community
     case analyze
     case setting
 }

class ViewRouter: ObservableObject {
     
     @Published var currentPage: Page = .home
     
 }
