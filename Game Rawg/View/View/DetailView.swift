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
    
    @ObservedObject var imageLoader : ImageLoader
    @ObservedObject var viewmodel = GameViewModel()
    
    init(game:Game) {
        self.game = game
        imageLoader = ImageLoader(urlString: game.gambar)
    }
    
    var body: some View {
        VStack {
            if viewmodel.loading {
                Spacer()
                ActivityIndicator(size: 80)
                Spacer()
            } else {
                ScrollView{
                    VStack {
                        Image(uiImage: (imageLoader.dataIsValid ? imageLoader.imageFromData() : UIImage(systemName: "questionmark")!))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color(.black))
                            .frame(height:120)
                        
                        Text(viewmodel.game.judul)
                            .font(.system(size: 16, weight: .bold))
                            .lineLimit(2)
                            .padding(5)
                        Divider()
                        HStack{
                            Text("Rate : "+String(viewmodel.game.peringkat))
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(.gray)
                            Spacer()
                        }.padding(.bottom,5)
                        HStack{
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
                    .padding()
            }
        }.onAppear{
            self.viewmodel.loadDataDetailGame(id: String(self.game.id))
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(game: Game(id: 1, judul: "wew", gambar: "url", tanggalRilis: "18 Juli 1997", peringkat: 9.0))
    }
}
