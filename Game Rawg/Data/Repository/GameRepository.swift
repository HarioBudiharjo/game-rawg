//
//  GameRepository.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 16/02/21.
//  Copyright © 2021 Hario Budiharjo. All rights reserved.
//

import Foundation

protocol GameRepository {
    func fetchListGame(completion: @escaping ([Game]?) -> Void)
    func fetchDetailGame(id: String,completion: @escaping (GameDetail?) -> Void)
    func fetchSearchGame(search: String,completion: @escaping ([Game]?) -> Void)
    func readAllFavorite() -> [Game]
    func checkingFavorite(id: Int) -> Bool
    func deleteFavorite(id: Int)
    func create(game: Game)
}

class GameRepositoryImpl: GameRepository {

    private let remoteDataSource: RemoteDataSource
    private let localeDataSource: LocaleDataSource

    init(remoteDataSource: RemoteDataSource, localeDataSource: LocaleDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localeDataSource = localeDataSource
    }

    func fetchSearchGame(search: String,completion: @escaping ([Game]?) -> Void) {
        self.remoteDataSource.fetchSearchGame(search: search) { (game) in
            var games : [Game] = []
            game?.results?.forEach({ (result) in
                games.append(Game(
                    id: result.id ?? 0,
                    name: result.name ?? "Unknnown",
                    image: result.backgroundImage ?? "Unavailable!",
                    release: result.released ?? "Undefine",
                    rating: Double(result.rating ?? 0)))
            })
            DispatchQueue.main.async {
                completion(games)
            }
        }
    }

    func fetchListGame(completion: @escaping ([Game]?) -> Void) {
        self.remoteDataSource.fetchListGame { (game) in
            var games : [Game] = []
            game?.results?.forEach({ (result) in
                games.append(Game(
                    id: result.id ?? 0,
                    name: result.name ?? "",
                    image: result.backgroundImage ?? "",
                    release: result.released ?? "",
                    rating: result.rating ?? 0.0))
            })
            DispatchQueue.main.async {
                completion(games)
            }
        }
    }

    func fetchDetailGame(id: String,completion: @escaping (GameDetail?) -> Void) {
        self.remoteDataSource.fetchDetailGame(id: id) { (game) in
            guard let game = game else {
                completion(nil)
                return
            }
            let detailGame = GameDetail(
                id: game.id ?? 0 ,
                name: game.name ?? "",
                description: game.descriptionRaw ?? "",
                image: game.backgroundImage ?? "",
                release: game.released ?? "",
                rating: game.rating ?? 0.0)

            DispatchQueue.main.async {
                completion(detailGame)
            }
        }
    }

    func readAllFavorite() -> [Game] {
        let game = self.localeDataSource.readAllFavorite()
        let output = game.map { (data) in
            return Game(id: data.id, name: data.name, image: data.image, release: data.release, rating: data.rating)
        }

        return output
    }

    func checkingFavorite(id: Int) -> Bool {
        return self.localeDataSource.checkingFavorite(id: id)
    }

    func deleteFavorite(id: Int) {
        self.localeDataSource.deleteFavorite(id: id)
    }

    func create(game: Game) {
        self.localeDataSource.create(game: game)
    }
}
