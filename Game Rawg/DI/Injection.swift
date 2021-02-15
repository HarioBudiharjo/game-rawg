//
//  Injection.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 15/02/21.
//  Copyright © 2021 Hario Budiharjo. All rights reserved.
//

import Foundation

final class Injection: NSObject {
    static func provideGameUseCase() -> GameUseCase {
        let gameUseCase = GameUseCaseImpl()
        return gameUseCase
    }
}
