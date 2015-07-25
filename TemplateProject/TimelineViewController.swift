//
//  TimelineViewController.swift
//  Renty
//
//  Created by yahya on 7/20/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    var manager: OneShotLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.tabBarController?.delegate = self
        manager = OneShotLocationManager()
        manager!.fetchWithCompletion {location, error in
            // fetch location or an error
            if let loc = location {
                println(location)
            } else if let err = error {
                println(err.localizedDescription)
            }
            self.manager = nil
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

}
//extension TimelineViewController: UITabBarControllerDelegate {
//    
//    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
//        if (viewController is PhotoTakingViewController) {
//            println("Take Photo")
//
//            return false
//        } else {
//            return true
//        }
//    }
//    
//}