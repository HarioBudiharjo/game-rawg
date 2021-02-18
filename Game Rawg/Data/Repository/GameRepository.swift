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
}

class GameRepositoryImpl: GameRepository {
    private let apiUrlBase = "https://api.rawg.io/api"
    func fetchSearchGame(search: String,completion: @escaping ([Game]?) -> Void) {
        let encodeUrl = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        guard let url = URL(string: "\(apiUrlBase)/games?search=\(String(describing: encodeUrl))") else { return }
        getData(url: url) { (data) in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let game = try? JSONDecoder().decode(SearchGameResponse.self, from: data) else {
                completion(nil)
                return
            }

            var games : [Game] = []
            game.results?.forEach({ (result) in
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
        guard let url = URL(string: "\(apiUrlBase)/games") else { return }
        getData(url: url) { (data) in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let game = try? JSONDecoder().decode(ListGameResponse.self, from: data) else {
                completion(nil)
                return
            }

            var games : [Game] = []
            game.results?.forEach({ (result) in
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
        guard let url = URL(string: "\(apiUrlBase)/games/\(id)") else { return }
        getData(url: url) { (data) in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let game = try? JSONDecoder().decode(DetailGameResponse.self, from: data) else {
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

    func getData(url:URL,completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) {(data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
}
