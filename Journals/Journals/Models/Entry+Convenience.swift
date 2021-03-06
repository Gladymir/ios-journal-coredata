//
//  Entry+Convenience.swift
//  Journals
//
//  Created by Gladymir Philippe on 8/5/20.
//  Copyright © 2020 Gladymir Philippe. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    @discardableResult convenience init(title: String?,
                                    bodyText: String?,
                                    timestamp: Date? = Date(),
                                    identifier: UUID = UUID(),
                                    context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

    self.init(context: context)
    self.title = title
    self.bodyText = bodyText
    self.timestamp = timestamp
        self.identifier = identifier.uuidString
}
}
