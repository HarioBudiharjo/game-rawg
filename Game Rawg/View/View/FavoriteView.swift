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
    let databaseHelper = DatabaseHelper()
    @State var games = [Game]()
    var body: some View {
        NavigationView {
            VStack{
                if (games.count>0) {
                    List(games){ game in
                        NavigationLink(destination: DetailView(game: game)) {
                            GameRow(game: game)
                        }
                    }
                } else {
                    Text("No games or error!")
                }
            }
            .navigationBarTitle(Text("Favorite"))
        }.onAppear{
            let game = self.databaseHelper.readAllFavorite()
            self.games = game
        }
    }
}
