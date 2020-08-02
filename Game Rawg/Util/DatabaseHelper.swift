//
//  DatabaseHelper.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 02/08/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

class DatabaseHelper {
    let entityFavorite = "Favorite"

    func readAllFavorite() -> [Game] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityFavorite)
        var games = [Game]()
        do {
            let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            result?.forEach { game in
                games.append(Game(
                    id: game.value(forKey: "id") as? Int ?? 0,
                    judul: game.value(forKey: "judul") as? String ?? "Unknown!",
                    gambar: game.value(forKey: "gambar") as? String ?? "Undefined!",
                    tanggalRilis: game.value(forKey: "tanggalRilis") as? String ?? "Undefined!",
                    peringkat: game.value(forKey: "peringkat") as? Double ?? 0.0))
            }
        } catch let err {
            print(err)
        }

        return games
    }

    func checkingFavorite(id:Int) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        var kembalian = false
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityFavorite)
        fetchRequest.predicate = NSPredicate(format: "id = %i", id)
        do {
            let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if (result?.count ?? 0) > 0 {
                kembalian = true
            }

        } catch let err {
            print(err)
        }

        return kembalian
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
        insert.setValue(game.gambar, forKey: "gambar")
        insert.setValue(game.judul, forKey: "judul")
        insert.setValue(game.peringkat, forKey: "peringkat")
        insert.setValue(game.tanggalRilis, forKey: "tanggalRilis")

        do {
            try managedContext.save()
        } catch let err {
            print(err)
        }

    }
}
