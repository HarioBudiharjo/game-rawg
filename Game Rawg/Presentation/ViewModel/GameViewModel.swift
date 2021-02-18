//
//  GameViewModel.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 07/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {

    private var cancellable: Set<AnyCancellable> = []
    private var scheduler = RunLoop.main

    @Published var games = GameList(results: [])
    @Published var loading = false
    @Published var game = GameDetail(
        id: 0,
        name: "",
        description: "",
        image: "",
        release: "",
        rating: 0.0
    )
    @Published var isFavorite = false

    let useCase: GameUseCase
    init(useCase: GameUseCase) {
        self.useCase = useCase
    }

    func loadDataListGame() {
        self.loading = true
        self.useCase.fetchListGame()
            .receive(on: self.scheduler)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.loading = false
                case .finished:
                    self.loading = false
                }
            }, receiveValue: { game in
                self.games.results = game
                self.loading = false
            })
            .store(in: &self.cancellable)
    }

    func loadDataDetailGame(id:String) {
        self.loading = true
        self.useCase.fetchDetailGame(id: id)
            .receive(on: self.scheduler)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.loading = false
                case .finished:
                    self.loading = false
                }
            }, receiveValue: { game in
                self.game = game
                self.loading = false
            })
            .store(in: &self.cancellable)
    }

    func loadDataSearchGame(search:String) {
        self.loading = true
        self.useCase.fetchSearchGame(search: search)
            .receive(on: self.scheduler)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.loading = false
                case .finished:
                    self.loading = false
                }
            }, receiveValue: { game in
                self.games.results = game
                self.loading = false
            })
            .store(in: &self.cancellable)
    }

    func isFavorite(id: Int) {
        self.useCase.isFavorite(id: id)
            .receive(on: self.scheduler)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    break
                case .finished:
                    break
                }
            }, receiveValue: { isSuccess in
                self.isFavorite = isSuccess
            })
            .store(in: &self.cancellable)
    }

    func readAllFavorite() {
        self.useCase.readAllFavorite()
            .receive(on: self.scheduler)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    break
                case .finished:
                    break
                }
            }, receiveValue: { games in
                self.games.results = games
            })
            .store(in: &self.cancellable)
    }

    func deleteFavorite(id: Int) {
        self.useCase.deleteFavorite(id: id)
            .receive(on: self.scheduler)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    break
                case .finished:
                    break
                }
            }, receiveValue: { isSuccess in
                print("success \(isSuccess)")
            })
            .store(in: &self.cancellable)
    }

    func createFavorite(game: Game) {
        self.useCase.create(game: game)
            .receive(on: self.scheduler)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    break
                case .finished:
                    break
                }
            }, receiveValue: { isSuccess in
                print("success \(isSuccess)")
            })
            .store(in: &self.cancellable)
    }
}
