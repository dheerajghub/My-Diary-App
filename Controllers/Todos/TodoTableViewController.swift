//
//  TodoTableViewController.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 23/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import RealmSwift

class TodoTableViewController: UITableViewController , ChangeCheckButton {
    
    let realm = try! Realm()
    
    var todoItems: Results<TodoItems>!
    
    var todo = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        loadTodo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpCustomNavBar()
    }
    
    func setUpCustomNavBar(){
        let add = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTodo))
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem  = add
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.title = "Todo"
    }
    
    @objc func editTodo(){
        
    }
    
    @objc func addTodo(){
        
        var todoAlertItem = UITextField()
        
        let alert = UIAlertController(title: "ADD NEW TODO", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newTodo = TodoItems()
            
            newTodo.task = todoAlertItem.text!
            
            self.saveTodoItems(item: newTodo)
            
            self.tableView.reloadData()
            
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create Todo"
            todoAlertItem = alertTextField
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK:- Data Manipulation
    
    func saveTodoItems(item: TodoItems){
        
        do {
            try realm.write {
                realm.add(item)
            }
        } catch  {
            print("Error: \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadTodo(){
        
        todoItems = realm.objects(TodoItems.self)
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        
        let cellData = todoItems[indexPath.row]
        cell.todoTask!.text = cellData.task
        cell.indexP = indexPath.row
        cell.todos = todo
        cell.delegate = self
        
//        if cell.todos![indexPath.row].done {
//            cell.checkCircle.setBackgroundImage(UIImage(named: "checked") , for: .normal)
//            cell.backgroundColor = UIColor(red: 0, green: 158.0, blue: 255.0, alpha: 0.2)
//        } else {
//            cell.checkCircle.setBackgroundImage(UIImage(named: "unchecked") , for: .normal)
//            cell.backgroundColor = UIColor.white
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexP = indexPath.row
        
        if let item = todoItems?[indexPath.row] {
            
            do{
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("ERROR: \(error)")
            }
            
            
        }
        
        if todoItems[indexPath.row].done {
            changeBtn(checked: false, index: indexP)
        } else {
            changeBtn(checked: true, index: indexP)
        }
    }
    
    func changeBtn(checked: Bool, index: Int) {
        todo[index].done = checked
        tableView.reloadData()
    }

    
    
}

