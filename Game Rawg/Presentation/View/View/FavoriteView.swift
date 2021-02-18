//
//  FavoriteView.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 29/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import SwiftUI
import CoreData

struct FavoriteView: View {
    @ObservedObject var viewmodel = GameViewModel(useCase: Injection.provideGameUseCase())
    var body: some View {
        NavigationView {
            VStack {
                if (!viewmodel.games.results.isEmpty) {
                    List(viewmodel.games.results) { game in
                        NavigationLink(destination: DetailView(game: game)) {
                            GameRow(game: game)
                        }
                    }
                } else {
                    Text("No games or error!")
                }
            }.onAppear {
                self.viewmodel.readAllFavorite()
            }
            .navigationBarTitle(Text("Favorite"))
        }
    }
}
