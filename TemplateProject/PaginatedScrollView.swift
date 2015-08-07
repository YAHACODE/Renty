//
//  PaginatedScrollView.swift
//  Renty
//
//  Created by yahya on 8/5/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class PaginatedScrollView: UIScrollView {

    var images: [UIImage]? {
        didSet {
            displayImages(images)
        }
    }
    
    func displayImages(images: [UIImage]?) {
        
        self.pagingEnabled = true // enable paging effect
        
        if let images = images {
            
            self.contentSize = CGSizeMake(self.frame.size.width * CGFloat(images.count), self.frame.size.height) // Set amount of room in scrollview to scroll around
            
            for var i = 0; i < images.count; i++ {
                
                println(self.frame.size.width)
                
                let image = images[i]
                let imageView = UIImageView(image: image)
                imageView.frame = CGRectMake(self.frame.size.width * CGFloat(i), 16  , self.frame.size.width, self.frame.size.width)
                imageView.contentMode = .ScaleAspectFill // Size image according to scrollview size
                imageView.clipsToBounds = true // don't let big images take up more space
                self.addSubview(imageView)
                
            }
            
        }
        
        
    }
    
}
