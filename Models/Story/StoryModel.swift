//
//  StoryModel.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 25/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import RealmSwift

//struct Story {
//
//    let image: String
//    let title: String
//    let writtenOn: String
//
//}

class Story: Object{
    
    @objc dynamic var story_ID = UUID().uuidString
    @objc dynamic var image: String = "img"
    @objc dynamic var title: String = ""
    @objc dynamic var story: String = ""
    @objc dynamic var writtenOn: String = ""
    
    
    override static func primaryKey() -> String?{
        return "story_ID"
    }
}

