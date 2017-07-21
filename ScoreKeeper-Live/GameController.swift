//
//  GameController.swift
//  ScoreKeeper-Live
//
//  Created by Taylor Mott on 20-Jul-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import Foundation
import CoreData

class GameController {
    static let shared = GameController()
    
    private let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (description: NSPersistentStoreDescription, error: Error?) in
            if let error = error {
                NSLog("Error loading persistent stores: \(error)")
            }
        }
    }
    
    func save() {
        do {
            try container.viewContext.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    // MARK: - Game CRUD
    
    @discardableResult func createGame(name: String, date: Date = Date()) -> Game {
        let game = Game(name: name, date: date, in: container.viewContext)
        save()
         return game
    }
    
    var games: [Game] {
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateLastPlayed", ascending: true)]
        var results = [Game]()
        
        container.viewContext.performAndWait {
            do {
                results = try fetchRequest.execute()
            } catch {
                NSLog("Error fetching games: \(error)")
            }
        }
        
        return results
    }
    
    func delete(_ game: Game) {
        container.viewContext.delete(game)
        save()
    }
    
    // MARK: - Player CRUD
    
    @discardableResult func createPlayer(name: String, score: Int64 = 0, game: Game? = nil) -> Player {
        let player = Player(name: name, score: score, game: game, in: container.viewContext)
        save()
        return player
    }
    
    func delete(_ player: Player) {
        container.viewContext.delete(player)
        save()
    }
    
}
