//
//  GameDetail.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 12/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation

struct GameDetail: Decodable, Identifiable {
    let id : Int
    let name : String
    let description : String
    let image : String
    let release : String
    let rating : Double
}
