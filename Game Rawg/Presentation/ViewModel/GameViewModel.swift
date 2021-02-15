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
    @Published var games = GameList(results: [])
    @Published var loading = false
    @Published var game = GameDetail(
        id: 0,
        judul: "",
        deskripsi: "",
        gambar: "",
        tanggalRilis: "",
        peringkat: 0.0)

    let service: GameUseCase
    init(service: GameUseCase) {
        self.service = service
    }

    func loadDataListGame() {
        self.loading = true
        service.fetchListGame { result in

            guard let games = result else {
                return
            }

            DispatchQueue.main.async {
                self.loading = false
                self.games.results = games
            }
        }
    }

    func loadDataDetailGame(id:String) {
        self.loading = true
        service.fetchDetailGame(id: id, completion: { result in
            guard let games = result else {
                return
            }

            DispatchQueue.main.async {
                self.loading = false
                self.game = games
            }
        })
    }

    func loadDataSearchGame(search:String) {
        self.loading = true
        service.fetchSearchGame(search: search, completion: { result in
            guard let games = result else {
                return
            }

            DispatchQueue.main.async {
                self.loading = false
                self.games.results = games
            }
        })
    }
}
