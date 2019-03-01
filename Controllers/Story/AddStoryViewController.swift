//
//  AddStoryViewController.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 27/01/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import RealmSwift

class AddStoryViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    let realm = try! Realm()
    
    
    struct customColor {
        
        static let transparentBlack = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
    }
    
    var imageName: String!
    
    @IBOutlet weak var storyTitle: UITextField!
    @IBOutlet weak var story: UITextView!
    @IBOutlet weak var subLayerForButtons: UIView!
    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var chooseImage: UIButton!
    @IBOutlet weak var pickFromCamera: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCustoms()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setUpCustomNavBar()
    }
    
    func setUpCustoms(){
        chooseImage.backgroundColor = UIColor(red: 0/255, green: 145/255, blue: 234/255, alpha: 1)
        chooseImage.layer.cornerRadius = 15
        chooseImage.layer.masksToBounds = true
        chooseImage.setTitleColor(UIColor.white, for: .normal)
        chooseImage.layer.shadowRadius = 16
        chooseImage.layer.shadowOffset = .zero
        chooseImage.layer.shadowOpacity = 0.4
        storyImage.contentMode = .scaleAspectFill
        storyImage.clipsToBounds = true
        pickFromCamera.setBackgroundImage(UIImage(named: "camera"), for: .normal)
        subLayerForButtons.setUpGradient(colorOne: customColor.transparentBlack , colorTwo: UIColor.black)
        story.backgroundColor = UIColor(red: 0/255, green: 145/255, blue: 234/255, alpha: 0.1)
        story.text = "Start your story from here..."
        story.layer.cornerRadius = 12
    }
    
    func setUpCustomNavBar(){
        
        let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(addStory))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = done
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.title = "Add Story"
        
    }
    
    // MARK:- Keyboard Adjustments
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        story.endEditing(true)
        storyTitle.endEditing(true)
    }
    
    @IBAction func chooseImageButton(_ sender: Any) {
        
        let controller = UIImagePickerController()
        controller.delegate = self // Remember: navigationControllerDelegate require.
        present(controller , animated: true , completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentPath = documentsURL.path
        let filePath = documentsURL.appendingPathComponent("\(randomString(length: 11)).png")
        
        // checking whether file already exist or not
        do{
            
            let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
            
            for file in files{
                if "\(documentPath)/\(file)" == filePath.path{
                    try fileManager.removeItem(atPath: "\(filePath.path)")
                }
            }
            
        } catch {
            
            print("Error: \(error)")
            
        }
        
        if let selectedImage = info[.originalImage] as? UIImage{
            storyImage.image = selectedImage
            imageName = filePath.path
            
            //creating image data and writing to filePath.
            do{
                
                if let pngImageData = selectedImage.pngData(){
                    try pngImageData.write(to: filePath, options: .atomic)
                }
                
            } catch {
                print("couldn't write image !")
            }
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cameraButton(_ sender: Any) {
        
        let controller = UIImagePickerController()
        controller.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            controller.sourceType = .camera
        } else {
            controller.sourceType = .photoLibrary
        }
        present(controller , animated: true , completion: nil)
    }
    
    //MAKS:- Buttons for operations.
    
    @objc func addStory(){
        
        let storyObj = Story()
        storyObj.image = imageName
        storyObj.title = storyTitle.text!
        storyObj.writtenOn = getDateFormatter(getFormat: "d MMM yy h:mm a")
        storyObj.story = story.text
        
        do {
            try realm.write{
                realm.add(storyObj)
            }
        } catch  {
            print("ERROR: \(error)")
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK:- Supportive functions
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
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

//MARK:- Add sublayer to the imageview inorder to make button more visible when image is selected.

extension UIView {
    
    func setUpGradient(colorOne: UIColor , colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor , colorTwo.cgColor]
        layer.insertSublayer(gradientLayer , at: 0)
        
    }
    
}
