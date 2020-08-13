//
//  EntryRepresentation.swift
//  Journals
//
//  Created by Gladymir Philippe on 8/12/20.
//  Copyright © 2020 Gladymir Philippe. All rights reserved.
//

import Foundation
import CoreData

struct EntryRepresentation: Codable {
    var bodyText: String?
    var identifier: String
    var mood: String
    var timestamp: Date
    var title: String
}
