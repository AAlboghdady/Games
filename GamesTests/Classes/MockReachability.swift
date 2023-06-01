//
//  MockReachability.swift
//  GamesTests
//
//  Created by Abdurrahman Alboghdady on 01/06/2023.
//

import Foundation
@testable import Games
import SystemConfiguration

class MockReachability: ReachabilityProtocol {
    private let status: ReachabilityStatus
    
    init(status: ReachabilityStatus) {
        self.status = status
    }
    
    func connectionStatus() -> ReachabilityStatus {
        return status
    }
}
