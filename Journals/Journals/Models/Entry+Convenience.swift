//
//  Entry+Convenience.swift
//  Journals
//
//  Created by Gladymir Philippe on 8/5/20.
//  Copyright © 2020 Gladymir Philippe. All rights reserved.
//

import Foundation
import CoreData

enum MoodPriority: String, CaseIterable {
    case 😒
    case 🙂
    case 😀
    
}
extension Entry {
    @discardableResult convenience init(title: String?,
                                    bodyText: String?,
                                    timestamp: Date? = Date(),
                                    identifier: UUID = UUID(),
                                    mood: MoodPriority = .🙂,
                                    context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

    self.init(context: context)
    self.title = title
    self.bodyText = bodyText
    self.timestamp = timestamp
    self.identifier = identifier.uuidString
    self.mood = mood.rawValue
    }
    
  @discardableResult convenience init?(entryRepresentation: EntryRepresentation,
                                             context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
            guard let mood = MoodPriority.init(rawValue: entryRepresentation.mood),
                let identifier = UUID(uuidString: entryRepresentation.identifier) else {
                    return nil
            }

    self.init(title: entryRepresentation.title,
              bodyText: entryRepresentation.bodyText ?? "",
              timestamp: entryRepresentation.timestamp,
              identifier: identifier,
    mood: mood,
    context: context)
        }

        var entryRepresentation: EntryRepresentation? {

            guard let title = title,
                let mood = mood,
                let timestamp = timestamp else { return nil }

            let id = identifier ?? UUID().uuidString

            return EntryRepresentation(bodyText: bodyText,
                                       identifier: id,
                                       mood: mood,
                                       timestamp: timestamp,
                                       title: title)

        }

    }
