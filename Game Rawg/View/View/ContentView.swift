//
//  ContentView.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 07/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
            }
            FavoriteView()
                .tabItem{
                    Image(systemName: "heart")
                    Text("Favorite")
            }
            AboutView()
                .tabItem {
                    Image(systemName: "person")
                    Text("About")
            }
        }.onAppear{
            SharedPref.checkingFirstLaunch()
        }
    }
}
