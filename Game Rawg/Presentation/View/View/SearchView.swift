//
//  SearchView.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 12/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import SwiftUI

struct SearchView: View {

    @State private var wasSearch = false
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @ObservedObject var viewmodel = GameViewModel(service: Injection.provideGameUseCase())

    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("search", text: $searchText, onEditingChanged: { _ in
                        self.showCancelButton = true
                    }, onCommit: {
                        self.wasSearch = true
                        self.viewmodel.loadDataSearchGame(search: self.searchText)
                    }).foregroundColor(.primary)

                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)

                if showCancelButton {
                    Button("Cancel") {
                        UIApplication.shared.endEditing(true)
                        self.searchText = ""
                        self.showCancelButton = false
                    }
                    .foregroundColor(Color(.systemBlue))
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(showCancelButton)

            VStack {
                if viewmodel.loading {
                    Spacer()
                    ActivityIndicator(size: 80)
                    Spacer()
                } else {
                    if (!viewmodel.games.results.isEmpty) {
                        List(viewmodel.games.results) { game in
                            NavigationLink(destination: DetailView(game: game)) {
                                GameRow(game: game)
                            }
                        }
                    } else {
                        Spacer()
                        Text(wasSearch ? "Data not found!" : "Let Search and click return!")
                        Spacer()
                    }
                }
            }

            .navigationBarTitle(Text("Search"))
            .resignKeyboardOnDragGesture()
        }.padding(.top,5)

    }
}
