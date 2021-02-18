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
        let gameUseCase = GameUseCaseImpl(repository: Injection.provideGameRepository())
        return gameUseCase
    }

    static func provideGameRepository() -> GameRepository {
        let gameRepository = GameRepositoryImpl(remoteDataSource: Injection.providerRemoteDataSource(), localeDataSource: Injection.providerLocaleDataSource())
        return gameRepository
    }

    static func providerRemoteDataSource() -> RemoteDataSource {
        let remoteDataSource = RemoteDataSourceImpl()
        return remoteDataSource
    }

    static func providerLocaleDataSource() -> LocaleDataSource {
        let localeDataSource = LocaleDataSourceImpl()
        return localeDataSource
    }
}
