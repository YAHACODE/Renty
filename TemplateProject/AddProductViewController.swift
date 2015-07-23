//
//  AddProductViewController.swift
//  Renty
//
//  Created by yahya on 7/22/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit



class AddProductViewController: UIViewController {
    
    @IBOutlet weak var capturedImage: UIImageView!
    @IBOutlet weak var capturedImage2: UIImageView!
    @IBOutlet weak var capturedImage3: UIImageView!
    
    var image1:UIImage?
    var image2:UIImage?
    var image3:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        capturedImage.image = image1
        capturedImage2.image = image2
        capturedImage3.image = image3


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
