//
//  NotesTableViewController.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 23/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class NotesTableViewController: UITableViewController , UINavigationControllerDelegate {
    
    let realm = try! Realm()
    
    var notes : Results<Notes>!
    var selectedNoteID: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadNotes()
        setUpCustomNavBar()
    }
    
    //MARK:- Data Manipulation
    
    func loadNotes(){
        
        notes = realm.objects(Notes.self)
        tableView.reloadData()
    }
    
    
    func setUpCustomNavBar(){
        let add = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNotes))
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem  = add
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.title = "Notes"
        
    }

    
    //TODO:- Editing Functionality
    

    
    @objc func addNotes(){
        
        performSegue(withIdentifier: "AddNote", sender: self)
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NotesTableViewCell 
        let cellData = notes[indexPath.row]
        
        cell.delegate = self
        cell.title.text = cellData.noteTitle.capitalized
        cell.note!.text = cellData.note
        cell.createdOn.text = cellData.createdOn
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedNoteID = notes[indexPath.row].note_ID
        
        performSegue(withIdentifier: "editNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editNote" {
            let desVC = segue.destination as! EditNotesViewController
            desVC.noteID = selectedNoteID
        }
        
    }

}

//MARK:- Swipe Cell Delegate method

extension NotesTableViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            if let noteForDeletion = self.notes?[indexPath.row] {
                do{
                    try self.realm.write {
                        self.realm.delete(noteForDeletion)
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


