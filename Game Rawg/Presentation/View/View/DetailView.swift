//
//  DetailView.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 07/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import SwiftUI

struct DetailView: View {

    var game : Game
    var gambarIsAvailable : Bool
    @ObservedObject var imageLoader : ImageLoader = ImageLoader()
    @ObservedObject var viewmodel = GameViewModel(service: Injection.provideGameUseCase())
    @State var like = false
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    let repository = Injection.provideGameRepository()

    init(game:Game) {
        self.game = game
        gambarIsAvailable = game.image == "Unavailable!" ? false : true
    }

    var body: some View {
        VStack {
            if viewmodel.loading {
                Spacer()
                ActivityIndicator(size: 80)
                Spacer()
            } else {
                ScrollView {
                    VStack {
                        if gambarIsAvailable {
                            if imageLoader.requestDone {
                                if imageLoader.dataIsValid {
                                    Image(uiImage: imageLoader.imageFromData())
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(Color(.black))
                                        .frame(height:120)
                                } else {
                                    Text("Image Empty")
                                }
                            } else {
                                Text("Loading Image...")
                            }
                        } else {
                            Text("Image Empty")
                        }

                        Text(viewmodel.game.name)
                            .font(.system(size: 16, weight: .bold))
                            .lineLimit(2)
                            .padding(5)
                        Divider()
                        HStack {
                            Text("Rate : "+String(viewmodel.game.rating))
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(.gray)
                            Spacer()
                        }.padding(.bottom,5)
                        HStack {
                            Text("Release : "+viewmodel.game.release)
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(.gray)
                            Spacer()
                        }.padding(.bottom,5)
                        Divider()
                        Text(viewmodel.game.description)
                        Spacer()
                    }
                }.navigationBarTitle(Text(viewmodel.game.name), displayMode: .inline)
                    .navigationBarItems(trailing:
                        Button(action: {
                            self.like = !self.like

                            if self.like {
                                self.repository.create(game: self.game)
                            } else {
                                self.repository.deleteFavorite(id: self.game.id)
                            }
                        }, label: {
                            Image(systemName: like ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        })
                )
                    .padding()
            }
        }.onAppear {
            self.imageLoader.setUrl(urlString: self.game.image)
            if self.gambarIsAvailable {
                self.imageLoader.getDataImage()
            }
            self.viewmodel.loadDataDetailGame(id: String(self.game.id))
            if self.repository.checkingFavorite(id: self.game.id) {
                self.like = true
            }

        }
    }
}
