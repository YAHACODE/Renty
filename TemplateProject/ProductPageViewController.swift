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
    
    var image1:UIImage?
    var image2:UIImage?
    var image3:UIImage?
    
    var post: Post? {
        didSet {
            displayPost(self.post)
        }
    }
   
    func displayPost( post: Post?) {
        if let post = post , titleTextlabel = titleTextlabel, descriptionLabel = descriptionLabel ,priceLabel = priceLabel , productimageview = productimageview,productimageview2 = productimageview2  , productimageview3 = productimageview3    {
      
            
            productimageview.image = post.image1.value
            productimageview2.image = post.image2.value
            productimageview3.image = post.image3.value

            titleTextlabel.text = post.title as String
            descriptionLabel.text = post.productdescription as? String
       
            // priceLabel.text = post.enteredprice

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
