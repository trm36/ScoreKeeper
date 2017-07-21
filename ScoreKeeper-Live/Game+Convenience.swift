//
//  Game+Convenience.swift
//  ScoreKeeper-Live
//
//  Created by Taylor Mott on 20-Jul-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import Foundation
import CoreData

extension Game {
    convenience init(name: String, date: Date = Date(), in context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.name = name
        self.dateLastPlayed = date as NSDate
    }
    
    var dateAsString: String? {
        guard let date = dateLastPlayed else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter.string(from: date as Date)
    }
}
