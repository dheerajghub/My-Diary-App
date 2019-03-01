//
//  todo.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 29/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import RealmSwift

class TodoItems: Object {
    
    @objc dynamic var task: String!
    @objc dynamic var done: Bool = false
    
}
