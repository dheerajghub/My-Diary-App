//
//  EditNotesViewController.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 28/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import RealmSwift
import TextFieldEffects

class EditNotesViewController: UIViewController , UITextViewDelegate {

    let realm = try! Realm()
    var noteID: String!

    @IBOutlet weak var noteTitle: HoshiTextField!
    
    @IBOutlet weak var noteContent: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNoteThroughID()
        setUpCustoms()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setUpCustomNavBar()
    }
    
    func setUpCustoms(){
        
        noteContent.delegate = self
        noteContent.isScrollEnabled = false
        noteContent.translatesAutoresizingMaskIntoConstraints = false
        noteContent!.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textViewDidChange(noteContent)
        noteContent.backgroundColor = UIColor(red: 0/255, green: 145/255, blue: 234/255, alpha: 0.1)
        noteContent.layer.cornerRadius = 6
        
    }
    
    func setUpCustomNavBar(){
        
        let save = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(saveChanges))
        navigationController?.navigationBar.topItem?.title = "Edit Note"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = save
        
    }
    
    //MARK:- get date in format
    #warning("Note: Refactor it later.")
    
    func getDateFormatter(getFormat : String) -> String {
        
        let date : Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = getFormat
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        noteContent.endEditing(true)
        noteTitle.endEditing(true)
    }
    
    func getNoteThroughID(){
        if let noteObject = realm.object(ofType: Notes.self, forPrimaryKey: noteID){
            noteContent.text = noteObject.note
            noteTitle.text = noteObject.noteTitle
        }
    }
    
    @objc func saveChanges(){
        
        let note = Notes()
        note.note_ID = noteID
        note.createdOn = getDateFormatter(getFormat: "dd/MM/yy  h:mm a")
        note.noteTitle = noteTitle.text!
        note.note = noteContent.text!
    
        do {
            try realm.write {
                realm.add(note , update: true)
            }
        } catch  {
            print("Error:\(error)")
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        let size = CGSize(width: view.frame.width , height: .infinity)
        let estimatedSize = noteContent.sizeThatFits(size)
        noteContent.constraints.forEach { (constraints) in
            if constraints.firstAttribute == .height{
                constraints.constant = estimatedSize.height
            }
        }
    }
}

