//
//  Error.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 18/02/21.
//  Copyright © 2021 Hario Budiharjo. All rights reserved.
//

import Foundation

public enum DatabaseError: LocalizedError {
    case appDelegateMissing
    case requestFailed
    case notFoundData

    public var errorDescription: String? {
        switch self {
        case .appDelegateMissing:
            return "App Delegate Missing!"
        case .requestFailed:
            return "Request failed!"
        case .notFoundData:
            return "Not Found Data!"
        }
    }
}

public enum RemoteError: LocalizedError {
    case urlNotValid
    case dataEmpty
    case failedJsonDecode

    public var errorDescription: String? {
        switch self {
        case .urlNotValid:
            return "Url Not Valid!"
        case .dataEmpty:
            return "Data empty!"
        case .failedJsonDecode:
            return "Failed JSON Decode!"
        }
    }
}
