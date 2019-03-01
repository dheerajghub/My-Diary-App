//
//  AddNoteViewController.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 28/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import RealmSwift
import TextFieldEffects

class AddNoteViewController: UIViewController {

    let realm = try! Realm()
    
    @IBOutlet weak var noteTitle: HoshiTextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCustoms()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setUpCustomNavBar()
    }
    
    func setUpCustoms(){
        
        noteTextView.delegate = self
        noteTextView.isScrollEnabled = false
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        noteTextView!.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textViewDidChange(noteTextView)
        noteTextView.backgroundColor = UIColor(red: 0/255, green: 145/255, blue: 234/255, alpha: 0.1)
        noteTextView.layer.cornerRadius = 6
        
    }
    
    func setUpCustomNavBar(){
        
        let save = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveNote))
        navigationController?.navigationBar.topItem?.title = "AddNote"
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
        noteTextView.endEditing(true)
        noteTitle.endEditing(true)
    }
    
    // MARK:- Data Manupulation
    
    @objc func saveNote(){
        
        let notes = Notes()
        
        notes.noteTitle = noteTitle.text!
        notes.note = noteTextView.text!
        notes.createdOn = getDateFormatter(getFormat: "dd/MM/yy  h:mm a")
        
        do {
            try realm.write{
                realm.add(notes)
            }
        } catch  {
            print("Some Error: \(error) Occurred!!")
        }
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
}

extension AddNoteViewController : UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        
        let size = CGSize(width: view.frame.width , height: .infinity)
        let estimatedSize = noteTextView.sizeThatFits(size)
        noteTextView.constraints.forEach { (constraints) in
            if constraints.firstAttribute == .height{
                constraints.constant = estimatedSize.height
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        noteTextView.text = ""
    }
    
}
