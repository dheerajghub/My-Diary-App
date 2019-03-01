//
//  StoryTableViewController.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 23/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class StoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var story: Results<Story>?
    var selectedStoryID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.separatorStyle = .none
        self.hero.isEnabled = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
        setUpCustomNavBar()
//        tableView.reloadData()
    }
    
    
    func setUpCustomNavBar(){
        let add = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addStory))
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem  = add
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.title = "Stories"
        
    }
    
    @objc func addStory(){
        
        performSegue(withIdentifier: "AddStory", sender: self)
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath) as! StoryTableViewCell
        
        if let cellData = story?[indexPath.row] {
            
            cell.storyImage.image = UIImage(named: "\(cellData.image)")
            cell.storyTitle.text = "\(cellData.title.capitalized)"
            cell.writtenOn.text = "\(cellData.writtenOn)"
            cell.storyPreview.text = "\(cellData.story.capitalized)"
            cell.selectionStyle = .none
            cell.delegate = self
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return story?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectedStoryID = story![indexPath.row].story_ID
        
        performSegue(withIdentifier: "detailStory", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailStory" {
            let desVC = segue.destination as! DetailStoryViewController
            desVC.storyID = selectedStoryID
        }
        
    }
    
    //MARK:- Data Manipulations
    
    func loadData(){
        story = realm.objects(Story.self)
        tableView.reloadData()
    }
}

extension StoryTableViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            if let storyForDeletion = self.story?[indexPath.row] {
                do{
                    try self.realm.write {
                        self.realm.delete(storyForDeletion)
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
}



