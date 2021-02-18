//
//  DetailGameResponse.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 12/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation

// MARK: - DetailGameResponse
struct DetailGameResponse: Codable {

    let id: Int?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let descriptionRaw: String?

    enum CodingKeys: String, CodingKey {
        case id, name, released, rating
        case backgroundImage = "background_image"
        case descriptionRaw = "description_raw"
    }
}
