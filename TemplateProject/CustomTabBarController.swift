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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        if item.title == "Item 3" {
            self.performSegueWithIdentifier("Camera", sender: self)
        }
    }



}
