//
//  Game.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 08/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation

struct Game: Decodable, Identifiable {
    let id : Int
    let judul : String
    let gambar : String
    let tanggalRilis : String
    let peringkat : Double
}
