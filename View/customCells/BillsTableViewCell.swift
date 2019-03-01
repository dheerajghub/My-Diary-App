//
//  BillsTableViewCell.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 26/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import SwipeCellKit

class BillsTableViewCell: SwipeTableViewCell  {

    @IBOutlet weak var billTypeImage: UIImageView!
    
    @IBOutlet weak var billType: UILabel!
    @IBOutlet weak var billTitle: UILabel!
    @IBOutlet weak var createdOn: UILabel!
    
    @IBOutlet weak var billIndicator: UIView!
    @IBOutlet weak var billAmt: UILabel!
    
    override func awakeFromNib() {
        
        billTypeImage.contentMode = .scaleAspectFill
        
    }
    
}
