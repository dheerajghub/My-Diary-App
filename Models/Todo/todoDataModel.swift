//
//  todoModels.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 27/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

struct Todo{

    var task = ""
    var done = false

    init(task: String ,done: Bool){
        self.task = task
        self.done = done
    }

}

