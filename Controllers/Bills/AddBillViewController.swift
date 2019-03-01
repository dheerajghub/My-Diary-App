//
//  AddBillViewController.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 30/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import RealmSwift
import TextFieldEffects

class AddBillViewController: UIViewController, UIPickerViewDelegate , UIPickerViewDataSource {
    
    let realm = try! Realm()
    
    var selectedTypeOfBill: String?
    
    var bill: Results<Bill>?
    
    @IBOutlet weak var billTitle: HoshiTextField!
    @IBOutlet weak var billAmt: HoshiTextField!
    
    var typeOfBill: [String]? = [String]()
    
    @IBOutlet weak var billType: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billType.delegate = self
        billType.dataSource = self
        typeOfBill = ["Lending" , "Spent" , "Withdraw"]
        
        billType.selectRow(0, inComponent: 0, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setUpCustomNavBar()
    }
    
    func setUpCustomNavBar(){
        
        let addBill = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveBill))
        
        navigationController?.navigationBar.topItem?.title = "Add Bill"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = addBill
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeOfBill?.count ?? 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeOfBill?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedTypeOfBill = typeOfBill?[row]
    }
    
    //MARK:- Data manipulation
    
    @objc func saveBill(){
    
        let bill = Bill()
            
        bill.billAmt = billAmt.text!
        bill.billTitle = billTitle.text!
        bill.billType = selectedTypeOfBill ?? "Lending"
        bill.createdOn = getDateFormatter(getFormat: "dd/MM/YY h:mm a")
        
        do {
            try realm.write {
                realm.add(bill)
            }
        } catch  {
            print("ERROR: \(error)")
        }
        
        navigationController?.popToRootViewController(animated: true)
        
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
    
}
