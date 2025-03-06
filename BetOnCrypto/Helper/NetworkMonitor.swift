//
//  NetworkMonitor.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/6/25.
//

import Foundation
import Network

final class NetworkMonitor {
    private let designatedQueue = DispatchQueue(label: "NetworkMonitoring_Queue")
    private let monitor: NWPathMonitor
    
    init() {
        self.monitor = NWPathMonitor()
    }
    
    func startMonitoring(networkStateHandler: @escaping (NWPath.Status) -> Void) {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                networkStateHandler(path.status)
            }
        }
        
        monitor.start(queue: designatedQueue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
