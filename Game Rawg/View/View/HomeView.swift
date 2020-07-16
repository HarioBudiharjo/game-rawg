//
//  HomeView.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 07/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewmodel = GameViewModel()
    var body: some View {
        NavigationView {
            VStack{
                if viewmodel.loading {
                    ActivityIndicator(size: 80)
                } else {
                    if (viewmodel.games.results.count > 0) {
                        List(viewmodel.games.results){ game in
                            NavigationLink(destination: DetailView(game: game)) {
                                GameRow(game: game)
                            }
                        }
                    } else {
                        Text("No games or error!")
                    }
                }
            }
            .onAppear{
                if !(self.viewmodel.games.results.count > 0) {
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
