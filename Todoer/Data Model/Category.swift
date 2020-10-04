//
//  Category.swift
//  Todoer
//
//  Created by Marta Sokołowska on 08/09/2020.
//  Copyright © 2020 Marta Sokołowska. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
