//
//  notesModel.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 26/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import RealmSwift

//struct Notes {
//    var noteTitle: String
//    var createdOn: String
//    var note: String
//}

class Notes: Object {
    
    @objc dynamic var note_ID = UUID().uuidString
    @objc dynamic var noteTitle: String = ""
    @objc dynamic var createdOn: String = ""
    @objc dynamic var note: String = ""
    
    override static func primaryKey() -> String?{
        return "note_ID"
    }
    
}
