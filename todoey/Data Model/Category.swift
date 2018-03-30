//
//  Category.swift
//  todoey
//
//  Created by Nguyen Duc Tai on 3/30/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import Foundation
import RealmSwift
class Category: Object {
    @objc dynamic var name:String = ""
    var items = List<Item>()
}
