//
//  Notification.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-04-03.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct Notification: Identifiable, Codable, Hashable {
    
    @DocumentID var id: String?
    var sender: String
    var senderName: String
    var reciever: String
    var habitTitle: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case sender
        case senderName
        case reciever
        case habitTitle
    }
    
}
