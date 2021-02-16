//
//  APIService.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 07/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation

protocol GameUseCase {
    func fetchListGame(completion: @escaping ([Game]?) -> Void)
    func fetchDetailGame(id: String,completion: @escaping (GameDetail?) -> Void)
    func fetchSearchGame(search: String,completion: @escaping ([Game]?) -> Void)
}

class GameUseCaseImpl : GameUseCase {

    private let repository: GameRepository

    init(repository: GameRepository) {
        self.repository = repository
    }

    func fetchSearchGame(search: String,completion: @escaping ([Game]?) -> Void) {
        return self.repository.fetchSearchGame(search: search) { (game) in
            completion(game)
        }
    }

    func fetchListGame(completion: @escaping ([Game]?) -> Void) {
        return self.repository.fetchListGame { (game) in
            completion(game)
        }
    }

    func fetchDetailGame(id: String,completion: @escaping (GameDetail?) -> Void) {
        return self.repository.fetchDetailGame(id: id) { (game) in
            completion(game)
        }
    }
}
