//
//  Service.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 28/05/2023.
//

import Foundation
import Combine

/// An abstract service type that can have multiple implementation for example - a NetworkService that gets a resource from the Network or a DiskService that gets a resource from Disk
protocol Service {
    func get<T: Codable>(function: ApiManager, model: T.Type, result: @escaping(Result<T, Error>)->())
    func cancelRequest()
}
