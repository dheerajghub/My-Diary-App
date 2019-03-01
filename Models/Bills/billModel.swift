//
//  billModel.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 26/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import RealmSwift

class Bill: Object{
    
    @objc dynamic var billTitle: String = "Bill Title"
    @objc dynamic var billType: String = "Lending"
    @objc dynamic var createdOn: String!
    @objc dynamic var billAmt: String = "0"
    
}
