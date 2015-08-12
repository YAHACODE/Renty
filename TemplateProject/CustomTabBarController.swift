//
//  CustomTabBarController.swift
//  Renty
//
//  Created by yahya on 7/22/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      // self.tabBarController?.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        if item.title == " " {
            self.performSegueWithIdentifier("Camera", sender: self)
        }
    }
  


}
// MARK: Tab Bar Delegate
/*
extension CustomTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is PhotoPickerController) {
            println("Take Photo")
            return false
        } else {
            return true
        }
    }
    
}*/