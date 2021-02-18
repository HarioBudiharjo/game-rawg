//
//  GameRow.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 07/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import SwiftUI

struct GameRow: View {

    var game: Game
    var gambarIsAvailable : Bool
    var favorite = false
    @ObservedObject var imageLoader : ImageLoader = ImageLoader()

    init(game : Game) {
        self.game = game
        gambarIsAvailable = game.image == "Unavailable!" ? false : true
    }

    var body: some View {
        HStack {
            if gambarIsAvailable {
                if imageLoader.requestDone {
                    if imageLoader.dataIsValid {
                        Image(uiImage: imageLoader.imageFromData())
                            .resizable()
                            .foregroundColor(Color(.black))
                            .aspectRatio(contentMode: .fill)
                            .frame(width:120)
                            .clipShape(Circle())
                    } else {
                        Text("Image Empty")
                    }
                } else {
                    Text("Loading Image...")
                }
            } else {
                Text("Image Empty")
            }

            VStack {
                Spacer()
                HStack {
                    Text(game.name)
                        .font(.system(size: 16, weight: .bold))
                        .lineLimit(2)
                        .padding(5)
                    Spacer()
                }
                Spacer()
                HStack {
                    Text("Release : "+game.release)
                        .font(.system(size: 14, weight: .regular))
                    Spacer()
                }
                HStack {
                    Text("Rate: \(game.rating.format())")
                        .font(.system(size: 14, weight: .regular))
                    Spacer()
                }
            }
        }.frame(height: 130).onAppear {
            self.imageLoader.setUrl(urlString: self.game.image)
            if self.gambarIsAvailable {
                self.imageLoader.getDataImage()
            }
        }
    }
}
