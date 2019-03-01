//
//  CustomTabBarController.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 23/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    var tabItem = UITabBarItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTabCustoms()
        customTab(selectedImage: "selectedStory", deselectedImage: "story", indexOfTab: 0 , tabTitle: "Story")
        customTab(selectedImage: "selectedBills", deselectedImage: "bills", indexOfTab: 1 , tabTitle: "Bills")
        customTab(selectedImage: "selectedTodo", deselectedImage: "todo", indexOfTab: 2 , tabTitle: "Todo")
        customTab(selectedImage: "selectedNotes", deselectedImage: "notes", indexOfTab: 3 , tabTitle: "Notes")

        
        
    }
    
    func setTabCustoms(){
        
            self.selectedIndex = 0
            self.tabBar.isTranslucent = false
            self.tabBar.barTintColor = UIColor.black
    }
    
    func customTab(selectedImage image1 : String , deselectedImage image2: String , indexOfTab index: Int , tabTitle title: String ){
        
        let selectedImage = UIImage(named: image1)!.withRenderingMode(.alwaysOriginal)
        let deselectedImage = UIImage(named: image2)!.withRenderingMode(.alwaysOriginal)
        tabItem = self.tabBar.items![index]
        tabItem.image = deselectedImage
        tabItem.selectedImage = selectedImage
        tabItem.title = .none
        tabItem.imageInsets.bottom = -10
        
    }

}
