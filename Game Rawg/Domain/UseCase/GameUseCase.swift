//
//  APIService.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 07/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation
import Combine

protocol GameUseCase {
    func fetchListGame() -> AnyPublisher<[Game], Error>
    func fetchDetailGame(id: String) -> AnyPublisher<GameDetail, Error>
    func fetchSearchGame(search: String) -> AnyPublisher<[Game], Error>

    func isFavorite(id: Int) -> AnyPublisher<Bool, Error>
    func readAllFavorite() -> AnyPublisher<[Game], Error>
    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error>
    func create(game: Game) -> AnyPublisher<Bool, Error>
}

class GameUseCaseImpl : GameUseCase {

    private let repository: GameRepository

    init(repository: GameRepository) {
        self.repository = repository
    }

    func fetchSearchGame(search: String) -> AnyPublisher<[Game], Error> {
        return self.repository.fetchSearchGame(search: search)
    }

    func fetchListGame() -> AnyPublisher<[Game], Error> {
        return self.repository.fetchListGame()
    }

    func fetchDetailGame(id: String) -> AnyPublisher<GameDetail, Error> {
        return self.repository.fetchDetailGame(id: id)
    }

    func isFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return self.repository.checkingFavorite(id: id)
    }

    func readAllFavorite() -> AnyPublisher<[Game], Error> {
        return self.repository.readAllFavorite()
    }

    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return self.repository.deleteFavorite(id: id)
    }

    func create(game: Game) -> AnyPublisher<Bool, Error> {
        return self.repository.create(game: game)
    }
}
