//
//  SearchGameResponse.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 12/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation

// MARK: - SearchGameResponse
struct SearchGameResponse: Codable {
    let results: [Result]?

    enum CodingKeys: String, CodingKey {
        case results
    }

    // MARK: - Result
    struct Result: Codable {
        let id: Int?
        let name: String?
        let released: String?
        let backgroundImage: String?
        let rating: Double?

        enum CodingKeys: String, CodingKey {
            case id, name, released, rating
            case backgroundImage = "background_image"
        }
    }
}
