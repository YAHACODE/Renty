//
//  ProductPageViewController.swift
//  Renty
//
//  Created by yahya on 7/29/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class ProductPageViewController: UIViewController {

    
    @IBOutlet weak var productimageview: UIImageView!
    
    @IBOutlet weak var productimageview2: UIImageView!
    
    @IBOutlet weak var productimageview3: UIImageView!
    
    @IBOutlet weak var titleTextlabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    var post: Post? {
        didSet {
            displayPost(self.post)
        }
    }
   
    func displayPost( post: Post?) {
        if let post = post , titleTextlabel = titleTextlabel, descriptionLabel = descriptionLabel ,priceLabel = priceLabel , productimageview = productimageview  {

         
//           productimageview.image = post.image1
            titleTextlabel.text = post.title as String
            descriptionLabel.text = post.productdescription as? String
            
            
//            if count(post.title)==0 && count(post.content)==0 { //1
//                titleTextField.becomeFirstResponder()
//            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        println(post)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        displayPost(post)
        
    }

}
