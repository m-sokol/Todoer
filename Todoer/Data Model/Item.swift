//
//  Item.swift
//  Todoer
//
//  Created by Marta Sokołowska on 08/09/2020.
//  Copyright © 2020 Marta Sokołowska. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
