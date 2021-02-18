//
//  GameRepository.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 16/02/21.
//  Copyright © 2021 Hario Budiharjo. All rights reserved.
//

import Foundation
import Combine

protocol GameRepository {
    func fetchListGame() -> AnyPublisher<[Game], Error>
    func fetchDetailGame(id: String) -> AnyPublisher<GameDetail, Error>
    func fetchSearchGame(search: String) -> AnyPublisher<[Game], Error>
    func readAllFavorite() -> AnyPublisher<[Game], Error>
    func checkingFavorite(id: Int) -> AnyPublisher<Bool, Error>
    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error>
    func create(game: Game) -> AnyPublisher<Bool, Error>
}

class GameRepositoryImpl: GameRepository {

    private let remoteDataSource: RemoteDataSource
    private let localeDataSource: LocaleDataSource

    init(remoteDataSource: RemoteDataSource, localeDataSource: LocaleDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localeDataSource = localeDataSource
    }

    func fetchSearchGame(search: String) -> AnyPublisher<[Game], Error> {
        return self.remoteDataSource.fetchSearchGame(search: search)
            .map { $0.mapToModel() }
            .eraseToAnyPublisher()
    }

    func fetchListGame() -> AnyPublisher<[Game], Error> {
        return self.remoteDataSource.fetchListGame()
            .map { $0.mapToModel() }
            .eraseToAnyPublisher()
    }

    func fetchDetailGame(id: String) -> AnyPublisher<GameDetail, Error> {
        return self.remoteDataSource.fetchDetailGame(id: id)
            .map { $0.mapToModel() }
            .eraseToAnyPublisher()
    }

    func readAllFavorite() -> AnyPublisher<[Game], Error> {
        return self.localeDataSource.readAllFavorite()
            .map { $0.mapToModel() }
            .eraseToAnyPublisher()
    }

    func checkingFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return self.localeDataSource.checkingFavorite(id: id).eraseToAnyPublisher()
    }

    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return self.localeDataSource.deleteFavorite(id: id).eraseToAnyPublisher()
    }

    func create(game: Game) -> AnyPublisher<Bool, Error> {
        return self.localeDataSource.create(game: game).eraseToAnyPublisher()
    }
}
