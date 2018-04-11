//
//  Item.swift
//  todoey
//
//  Created by Nguyen Duc Tai on 3/30/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import Foundation
import RealmSwift
class Item: Object {
    @objc dynamic var title:String = ""
    @objc dynamic var done:Bool = false
    @objc dynamic var date:Date?
    var yourParent = LinkingObjects(fromType: Category.self, property: "items")
    
}
