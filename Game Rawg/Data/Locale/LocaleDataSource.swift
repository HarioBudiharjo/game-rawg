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

protocol LocaleDataSource {
    func readAllFavorite() -> [GameEntity]
    func checkingFavorite(id: Int) -> Bool
    func deleteFavorite(id: Int)
    func create(game: Game)
}

class LocaleDataSourceImpl: LocaleDataSource {
    let entityFavorite = "Favorite"

    func readAllFavorite() -> [GameEntity] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityFavorite)
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
        } catch let err {
            print(err)
        }

        return games
    }

    func checkingFavorite(id:Int) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        var favorite = false
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityFavorite)
        fetchRequest.predicate = NSPredicate(format: "id = %i", id)
        do {
            let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if (result?.count ?? 0) > 0 {
                favorite = true
            }

        } catch let err {
            print(err)
        }

        return favorite
    }

    func deleteFavorite(id:Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entityFavorite)
        fetchRequest.predicate = NSPredicate(format: "id = %i", id)

        do {
            guard let dataToDelete = try managedContext.fetch(fetchRequest)[0] as? NSManagedObject
                else { return }
            managedContext.delete(dataToDelete)
            try managedContext.save()
        } catch let err {
            print(err)
        }
    }

    func create(game:Game) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: entityFavorite, in: managedContext)
        let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        insert.setValue(game.id, forKey: "id")
        insert.setValue(game.image, forKey: "gambar")
        insert.setValue(game.name, forKey: "judul")
        insert.setValue(game.rating, forKey: "peringkat")
        insert.setValue(game.release, forKey: "tanggalRilis")

        do {
            try managedContext.save()
        } catch let err {
            print(err)
        }

    }
}
