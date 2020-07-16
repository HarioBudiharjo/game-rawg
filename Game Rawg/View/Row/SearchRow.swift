//
//  SearchRow.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 12/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import SwiftUI

struct SearchRow: View {
    var game: Game
    @ObservedObject var imageLoader : ImageLoader
    
    init(game : Game) {
        self.game = game
        imageLoader = ImageLoader(urlString: game.gambar)
    }
    
    var body: some View {
        HStack {

            if imageLoader.dataIsValid {
                Image(uiImage: imageLoader.imageFromData())
                    .resizable()
                    .foregroundColor(Color(.black))
                    .aspectRatio(contentMode: .fill)
                    .frame(width:120)
                .clipShape(Circle())
            } else {
                Text("Loading Image...")
            }
            
            VStack {
                Spacer()
                Text(game.judul)
                    .font(.system(size: 16, weight: .bold))
                    .lineLimit(2)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.blue)
                    .cornerRadius(5)
                Spacer()
                HStack{
                    Spacer()
                    Text("Release : "+game.tanggalRilis)
                        .font(.system(size: 11, weight: .regular))
                }
            }
        }.frame(height: 130)
    }
}

struct SearchRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchRow(game: Game(id: 1, judul: "hello", gambar: "https://avatars2.githubusercontent.com/u/10007846?s=460&u=dd0a404a51a0d26d9035843559a22bc2adbf0bc6&v=4", tanggalRilis: "18 Juli 1997", peringkat: 4.9))
    }
}
