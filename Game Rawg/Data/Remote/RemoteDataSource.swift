//
//  RemoteDataSource.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 18/02/21.
//  Copyright © 2021 Hario Budiharjo. All rights reserved.
//

import Foundation

protocol RemoteDataSource {
    func fetchSearchGame(search: String, completion: @escaping (SearchGameResponse?) -> Void)

    func fetchListGame(completion: @escaping (ListGameResponse?) -> Void)

    func fetchDetailGame(id: String, completion: @escaping (DetailGameResponse?) -> Void)
}

class RemoteDataSourceImpl: RemoteDataSource {
    private let apiUrlBase = "https://api.rawg.io/api"
    func fetchSearchGame(search: String,completion: @escaping (SearchGameResponse?) -> Void) {
        let encodeUrl = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        guard let url = URL(string: "\(apiUrlBase)/games?search=\(String(describing: encodeUrl))") else { return }
        getData(url: url) { (data) in
            guard let data = data else {
                completion(nil)
                return
            }
            let game = try? JSONDecoder().decode(SearchGameResponse.self, from: data)
            completion(game)
        }
    }

    func fetchListGame(completion: @escaping (ListGameResponse?) -> Void) {
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
            completion(game)
        }
    }

    func fetchDetailGame(id: String,completion: @escaping (DetailGameResponse?) -> Void) {
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
            completion(game)
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
