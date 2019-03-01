//
//  DetailStoryViewController.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 01/02/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import RealmSwift

class DetailStoryViewController: UIViewController {

    let realm = try! Realm()
    var storyID: String!
    
    @IBOutlet weak var storyTitle: UILabel!
    @IBOutlet weak var StoryImage: UIImageView!
    @IBOutlet weak var writtenOn: UILabel!
    @IBOutlet weak var story: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationCustom()
        getNoteThroughID()
    }
    
    func getNoteThroughID(){
        if let storyObject = realm.object(ofType: Story.self, forPrimaryKey: storyID){
            storyTitle.text = storyObject.title
            StoryImage.image = UIImage(named: storyObject.image)
            writtenOn.text = storyObject.writtenOn
            story.text = storyObject.story
        }
    }
    
    func setUpNavigationCustom(){
        
        navigationController?.navigationBar.topItem?.title = "Story Preview"
        
    }
 
}
