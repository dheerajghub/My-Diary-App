//
//  BillsTableViewController.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 23/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class BillsTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var bill: Results<Bill>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        loadBills()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpCustomNavBar()
        tableView.reloadData()
    }
    
    func setUpCustomNavBar(){
//        let info = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(searchBills))
        let add = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addBills))
        
//        navigationController?.navigationBar.topItem?.leftBarButtonItem  = info
        navigationController?.navigationBar.topItem?.rightBarButtonItem  = add
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.title = "Bills"
    }
    
//    @objc func searchBills(){
//
//    }
    
    @objc func addBills(){
        
        performSegue(withIdentifier: "addBills", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billCell", for: indexPath) as! BillsTableViewCell
        
        
        if let cellData = bill?[indexPath.row] {
            
            if cellData.billType == "Lending"{
                cell.billIndicator.backgroundColor = .orange
                cell.billType.textColor = .orange
            } else if cellData.billType == "Spent" {
                cell.billIndicator.backgroundColor = .red
                cell.billType.textColor = .red
            } else if cellData.billType == "Withdraw" {
                cell.billIndicator.backgroundColor = UIColor(red: 0/255, green: 237/255, blue: 146/255, alpha: 1)
                cell.billType.textColor = UIColor(red: 2/255, green: 131/255, blue: 81/255, alpha: 1)
            }
            cell.delegate = self
            cell.billTitle.text = cellData.billTitle.capitalized
            cell.billTypeImage.image = UIImage(named: cellData.billType)
            cell.createdOn.text = cellData.createdOn
            cell.billAmt.text = "₹\(cellData.billAmt)"
            cell.billType.text = cellData.billType
            cell.selectionStyle = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bill?.count ?? 1
    }
    
    
    //MARK:- Data manipulation
    
    func loadBills(){
        bill = realm.objects(Bill.self)
        tableView.reloadData()
    }

}

extension BillsTableViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            if let billForDeletion = self.bill?[indexPath.row] {
                do{
                    try self.realm.write {
                        self.realm.delete(billForDeletion)
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
