//
//  APIService.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 07/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    func fetchListGame(completion: @escaping ([Game]?) -> Void)
    func fetchDetailGame(id: String,completion: @escaping (GameDetail?) -> Void)
    func fetchSearchGame(search: String,completion: @escaping ([Game]?) -> Void)
}

class APIService : ServiceProtocol {
    private let apiUrlBase = "https://api.rawg.io/api"
    func fetchSearchGame(search: String,completion: @escaping ([Game]?) -> Void) {
        guard let url = URL(string: "\(apiUrlBase)/games?search=\(search)") else { return }
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
                    judul: result.name ?? "Unknnown",
                    gambar: result.backgroundImage ?? "Unavailable!",
                    tanggalRilis: result.released ?? "Undefine",
                    peringkat: Double(result.rating ?? 0)))
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
                    judul: result.name ?? "",
                    gambar: result.backgroundImage ?? "",
                    tanggalRilis: result.released ?? "",
                    peringkat: result.rating ?? 0.0))
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
                judul: game.name ?? "",
                deskripsi: game.descriptionRaw ?? "",
                gambar: game.backgroundImage ?? "",
                tanggalRilis: game.released ?? "",
                peringkat: game.rating ?? 0.0)

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
