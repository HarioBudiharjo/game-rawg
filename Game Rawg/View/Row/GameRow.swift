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
    @ObservedObject var imageLoader : ImageLoader
    
    init(game : Game) {
        self.game = game
        imageLoader = ImageLoader(urlString: game.gambar)
        gambarIsAvailable = game.gambar == "Unavailable!" ? false : true
        if gambarIsAvailable {
            imageLoader.getDataImage()
        }
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
                    Text(game.judul)
                        .font(.system(size: 16, weight: .bold))
                        .lineLimit(2)
                        .padding(5)
                    Spacer()
                }
                Spacer()
                HStack{
                    Text("Release : "+game.tanggalRilis)
                        .font(.system(size: 11, weight: .regular))
                    Spacer()
                }
                HStack{
                    Text("Rate: \(game.peringkat.format())")
                        .font(.system(size: 11, weight: .regular))
                    Spacer()
                }
            }
        }.frame(height: 130)
    }
}
