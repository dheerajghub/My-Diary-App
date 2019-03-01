//
//  TodoTableViewCell.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 25/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

protocol ChangeCheckButton {
    func changeBtn(checked: Bool , index: Int)
}

class TodoTableViewCell: UITableViewCell {

    var delegate: ChangeCheckButton?
    var indexP: Int?
    var todos: [Todo]?
    
    @IBOutlet var checkCircle: UIButton!
    @IBOutlet var todoTask: UILabel!
    
    @IBAction func checkCircleAction(_ sender: Any) {
        
        if todos![indexP!].done{
            delegate?.changeBtn(checked: false, index: indexP!)
        } else {
            delegate?.changeBtn(checked: true, index: indexP!)
        }
        
    }
}
