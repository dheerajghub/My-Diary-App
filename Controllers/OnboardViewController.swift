//
//  OnboardViewController.swift
//  MyDiary
//
//  Created by Dheeraj Kumar Sharma on 01/02/19.
//  Copyright © 2019 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import paper_onboarding

class OnboardViewController: UIViewController, PaperOnboardingDataSource , PaperOnboardingDelegate {
    

    @IBOutlet weak var getStarted: UIButton!
    @IBOutlet weak var onboardingView: OnboardingView!
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.delegate = self
        onboardingView.dataSource = self
    }
    
    
    func onboardingItemsCount() -> Int {
        return 4
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        let bgColor1 = UIColor(red: 166/255, green: 130/255, blue: 255/255, alpha: 1)
        let bgColor2 = UIColor(red: 113/255, green: 90/255, blue: 255/255, alpha: 1)
        let bgColor3 = UIColor(red: 88/255, green: 135/255, blue: 255/255, alpha: 1)
        let bgColor4 = UIColor(red: 126/255, green: 188/255, blue: 230/255, alpha: 1)
        
        let titleFont = UIFont(name: "Futura-Bold", size: 25)
        let descriptionFont = UIFont(name: "Avenir-Medium", size: 20)
        
        return [
            OnboardingItemInfo(informationImage: UIImage(named: "OnboardStoryMain")!,
                               title: "Create Your Stories",
                               description: "You can create your stories and can capture you favorite moments.",
                               pageIcon: UIImage(named: "hello")!,
                               color: bgColor1,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: titleFont!,
                               descriptionFont: descriptionFont!),
            OnboardingItemInfo(informationImage: UIImage(named: "OnboardBillMain")!,
                               title: "Create Bills To Keep Record",
                               description: "You can keep the record of your bills and manage them accordingly.",
                               pageIcon: UIImage(named: "hello")!,
                               color: bgColor2,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: titleFont!,
                               descriptionFont: descriptionFont!),
            OnboardingItemInfo(informationImage: UIImage(named: "OnboardTodoMain")!,
                               title: "Manage Your Work",
                               description: "You can keep yourself persistent through managing your todos.",
                               pageIcon: UIImage(named: "hello")!,
                               color: bgColor3,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: titleFont!,
                               descriptionFont: descriptionFont!),
            OnboardingItemInfo(informationImage: UIImage(named: "OnboardNotesMain")!,
                               title: "Create Notes",
                               description: "This is perfect solution to add those tips and tricks that your teacher tells you and More.",
                               pageIcon: UIImage(named: "hello")!,
                               color: bgColor4,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: titleFont!,
                               descriptionFont: descriptionFont!)
            ][index]
        
    }

    func onboardingConfigurationItem(item: OnboardingContentViewItem, index: Int) {
        

    }
    
    func onboardingDidTransitonToIndex(_ index : Int) {
        if index == 3{
            UIView.animate(withDuration: 0.4) {
                self.getStarted.alpha = 1
            }
        }
    }
    
    
    func onboardingWillTransitonToIndex(_ index : Int) {
        if index == 2{
            
            if self.getStarted.alpha == 1{
                UIView.animate(withDuration: 0.4, animations: {
                    self.getStarted.alpha = 0
                })
            }
        }
    }

    @IBAction func gotStarted(_ sender: Any) {
        
        let userDefault = UserDefaults.standard
        
        userDefault.set(true, forKey: "onboardingCompletes")
        
        userDefault.synchronize()
    }
}
