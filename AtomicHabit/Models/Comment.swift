//
//  Comments.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-16.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct Comment: Identifiable, Codable, Hashable {
    
    @DocumentID var id: String?
    var comment: String
    var commenterID: String?
    var commenterName: String?
    var recieverID: String?
    var habitID: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case comment
        case commenterID
        case commenterName
        case recieverID
        case habitID
        
    }
    
}



