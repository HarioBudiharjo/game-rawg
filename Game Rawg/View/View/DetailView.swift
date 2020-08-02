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
    @ObservedObject var viewmodel = GameViewModel()
    @State var like = false
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    let databaseHelper = DatabaseHelper()

    init(game:Game) {
        self.game = game
        gambarIsAvailable = game.gambar == "Unavailable!" ? false : true
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

                        Text(viewmodel.game.judul)
                            .font(.system(size: 16, weight: .bold))
                            .lineLimit(2)
                            .padding(5)
                        Divider()
                        HStack {
                            Text("Rate : "+String(viewmodel.game.peringkat))
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(.gray)
                            Spacer()
                        }.padding(.bottom,5)
                        HStack {
                            Text("Release : "+viewmodel.game.tanggalRilis)
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(.gray)
                            Spacer()
                        }.padding(.bottom,5)
                        Divider()
                        Text(viewmodel.game.deskripsi)
                        Spacer()
                    }
                }.navigationBarTitle(Text(viewmodel.game.judul), displayMode: .inline)
                    .navigationBarItems(trailing:
                        Button(action: {
                            self.like = !self.like

                            if self.like {
                                self.databaseHelper.create(game: self.game)
                            } else {
                                self.databaseHelper.deleteFavorite(id: self.game.id)
                            }
                        }, label: {
                            Image(systemName: like ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        })
                )
                    .padding()
            }
        }.onAppear {
            self.imageLoader.setUrl(urlString: self.game.gambar)
            if self.gambarIsAvailable {
                self.imageLoader.getDataImage()
            }
            self.viewmodel.loadDataDetailGame(id: String(self.game.id))
            if self.databaseHelper.checkingFavorite(id: self.game.id) {
                self.like = true
            }

        }
    }
}
