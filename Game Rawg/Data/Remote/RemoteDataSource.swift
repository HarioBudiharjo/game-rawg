//
//  RemoteDataSource.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 18/02/21.
//  Copyright © 2021 Hario Budiharjo. All rights reserved.
//

import Foundation
import Combine

protocol RemoteDataSource {
    func fetchSearchGame(search: String) -> AnyPublisher<[SearchGameResponse.Result], Error>
    func fetchListGame() -> AnyPublisher<[ListGameResponse.Result], Error>
    func fetchDetailGame(id: String) -> AnyPublisher<DetailGameResponse, Error>
}

class RemoteDataSourceImpl: RemoteDataSource {
    private let apiUrlBase = "https://api.rawg.io/api"
    func fetchSearchGame(search: String) -> AnyPublisher<[SearchGameResponse.Result], Error> {
        return Future<[SearchGameResponse.Result], Error> { completion in
            let encodeUrl = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
            guard let url = URL(string: "\(self.apiUrlBase)/games?search=\(String(describing: encodeUrl))") else {
                completion(.failure(RemoteError.urlNotValid))
                return
            }
            self.getData(url: url) { (data) in
                guard let data = data else {
                    completion(.failure(RemoteError.dataEmpty))
                    return
                }
                guard let game = try? JSONDecoder().decode(SearchGameResponse.self, from: data) else {
                    completion(.failure(RemoteError.failedJsonDecode))
                    return
                }
                guard let result = game.results else {
                    completion(.failure(RemoteError.failedJsonDecode))
                    return
                }
                completion(.success(result))
            }
        }.eraseToAnyPublisher()
    }

    func fetchListGame() -> AnyPublisher<[ListGameResponse.Result], Error> {
        return Future<[ListGameResponse.Result], Error> { completion in
            guard let url = URL(string: "\(self.apiUrlBase)/games") else {
                completion(.failure(RemoteError.urlNotValid))
                return
            }
            self.getData(url: url) { (data) in
                guard let data = data else {
                    completion(.failure(RemoteError.dataEmpty))
                    return
                }
                guard let game = try? JSONDecoder().decode(ListGameResponse.self, from: data) else {
                    completion(.failure(RemoteError.failedJsonDecode))
                    return
                }
                guard let result = game.results else {
                    completion(.failure(RemoteError.failedJsonDecode))
                    return
                }
                completion(.success(result))
            }
        }.eraseToAnyPublisher()
    }

    func fetchDetailGame(id: String) -> AnyPublisher<DetailGameResponse, Error> {
        return Future<DetailGameResponse, Error> { completion in
            guard let url = URL(string: "\(self.apiUrlBase)/games/\(id)") else {
                completion(.failure(RemoteError.urlNotValid))
                return
            }
            self.getData(url: url) { (data) in
                guard let data = data else {
                    completion(.failure(RemoteError.dataEmpty))
                    return
                }
                guard let game = try? JSONDecoder().decode(DetailGameResponse.self, from: data) else {
                    completion(.failure(RemoteError.failedJsonDecode))
                    return
                }
                completion(.success(game))
            }
        }.eraseToAnyPublisher()
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
