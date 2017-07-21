//
//  Player+Convenience.swift
//  ScoreKeeper-Live
//
//  Created by Taylor Mott on 20-Jul-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import Foundation
import CoreData

extension Player {
    convenience init(name: String, score: Int64 = 0, game: Game? = nil, in context:NSManagedObjectContext) {
        self.init(context: context)
        
        self.name = name
        self.score = score
        self.game = game
    }
}
