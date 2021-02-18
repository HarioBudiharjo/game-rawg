//
//  HomeView.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 07/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewmodel : GameViewModel = GameViewModel(useCase: Injection.provideGameUseCase())
    var body: some View {
        NavigationView {
            VStack {
                if viewmodel.loading {
                    ActivityIndicator(size: 80)
                } else {
                    if (!viewmodel.games.results.isEmpty) {
                        List(viewmodel.games.results) { game in
                            NavigationLink(destination: DetailView(game: game)) {
                                GameRow(game: game)
                            }
                        }
                    } else {
                        Text("No games or error!")
                    }
                }
            }
            .onAppear {
                if !(!self.viewmodel.games.results.isEmpty) {
                    self.viewmodel.loadDataListGame()
                }
            }
            .navigationBarTitle(Text("Game Rawg"))
            .navigationBarItems(trailing:
                NavigationLink(destination: SearchView()) {
                    Image(systemName: "magnifyingglass")
                }
            )
        }
    }
}
