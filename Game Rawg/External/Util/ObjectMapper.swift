//
//  ObjectMapper.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 18/02/21.
//  Copyright © 2021 Hario Budiharjo. All rights reserved.
//

import Foundation

extension Array where Element == SearchGameResponse.Result {
    func mapToModel() -> [Game] {
        self.map { result in
            return Game(
                id: result.id ?? 0,
                name: result.name ?? "Unknnown",
                image: result.backgroundImage ?? "Unavailable!",
                release: result.released ?? "Undefine",
                rating: Double(result.rating ?? 0))
        }
    }
}

extension Array where Element == ListGameResponse.Result {
    func mapToModel() -> [Game] {
        self.map { result in
            return Game(
                id: result.id ?? 0,
                name: result.name ?? "Unknnown",
                image: result.backgroundImage ?? "Unavailable!",
                release: result.released ?? "Undefine",
                rating: Double(result.rating ?? 0))
        }
    }
}

extension DetailGameResponse {
    func mapToModel() -> GameDetail {

        return GameDetail(id: self.id ?? 0,
                          name: self.name ?? "",
                          description: self.descriptionRaw ?? "",
                          image: self.backgroundImage ?? "",
                          release: self.released ?? "",
                          rating: self.rating ?? 0.0
        )
    }
}

extension Array where Element == GameEntity {
    func mapToModel() -> [Game] {
        self.map { result in
            return Game(id: result.id, name: result.name, image: result.image, release: result.release, rating: result.rating)
        }
    }
}
