//
//  TestNetwork.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-04-13.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI
import Network


class NetworkManager: ObservableObject{
    
    @Published var networkStatus = true
    
    init() {
        monitorNetwork()
    }
    
    func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.networkStatus = true
                }
            } else {
                DispatchQueue.main.async {
                    self.networkStatus = false
                }
            }
            
        }
        
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
}
