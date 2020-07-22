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

extension Double {
    func format() -> String {
        return String(format: "%.2f",self)
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(game: Game(id: 1, judul: "hello", gambar: "https://avatars2.githubusercontent.com/u/10007846?s=460&u=dd0a404a51a0d26d9035843559a22bc2adbf0bc6&v=4", tanggalRilis: "18 Juli 1997", peringkat: 4.9))
    }
}
