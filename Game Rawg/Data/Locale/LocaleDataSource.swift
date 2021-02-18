//
//  LocaleDataSource.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 18/02/21.
//  Copyright © 2021 Hario Budiharjo. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine

protocol LocaleDataSource {
    func readAllFavorite() -> AnyPublisher<[GameEntity], Error>
    func checkingFavorite(id:Int) -> AnyPublisher<Bool, Error>
    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error>
    func create(game: Game) -> AnyPublisher<Bool, Error>
}

class LocaleDataSourceImpl: LocaleDataSource {
    let entityFavorite = "Favorite"

    func readAllFavorite() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                completion(.failure(DatabaseError.appDelegateMissing))
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityFavorite)
            var games = [GameEntity]()
            do {
                let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

                result?.forEach { game in
                    games.append(GameEntity(
                        id: game.value(forKey: "id") as? Int ?? 0,
                        name: game.value(forKey: "judul") as? String ?? "Unknown!",
                        image: game.value(forKey: "gambar") as? String ?? "Undefined!",
                        release: game.value(forKey: "tanggalRilis") as? String ?? "Undefined!",
                        rating: game.value(forKey: "peringkat") as? Double ?? 0.0))
                }
            } catch _ {
                completion(.failure(DatabaseError.requestFailed))
            }
            completion(.success(games))
        }.eraseToAnyPublisher()
    }

    func checkingFavorite(id:Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                completion(.failure(DatabaseError.appDelegateMissing))
                return
            }
            var favorite = false
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityFavorite)
            fetchRequest.predicate = NSPredicate(format: "id = %i", id)
            do {
                let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

                if (result?.count ?? 0) > 0 {
                    favorite = true
                }

            } catch _ {
                completion(.failure(DatabaseError.requestFailed))
            }
            completion(.success(favorite))
        }.eraseToAnyPublisher()
    }

    func deleteFavorite(id:Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                completion(.failure(DatabaseError.appDelegateMissing))
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext

            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: self.entityFavorite)
            fetchRequest.predicate = NSPredicate(format: "id = %i", id)

            do {
                guard let dataToDelete = try managedContext.fetch(fetchRequest)[0] as? NSManagedObject else {
                    completion(.failure(DatabaseError.notFoundData))
                    return
                }
                managedContext.delete(dataToDelete)
                try managedContext.save()
            } catch _ {
                completion(.failure(DatabaseError.requestFailed))
            }
            completion(.success(true))
        }.eraseToAnyPublisher()
    }

    func create(game:Game) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                completion(.failure(DatabaseError.appDelegateMissing))
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            let userEntity = NSEntityDescription.entity(forEntityName: self.entityFavorite, in: managedContext)
            let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
            insert.setValue(game.id, forKey: "id")
            insert.setValue(game.image, forKey: "gambar")
            insert.setValue(game.name, forKey: "judul")
            insert.setValue(game.rating, forKey: "peringkat")
            insert.setValue(game.release, forKey: "tanggalRilis")

            do {
                try managedContext.save()
            } catch _ {
                completion(.failure(DatabaseError.requestFailed))
            }
            completion(.success(true))
        }.eraseToAnyPublisher()
    }
}
