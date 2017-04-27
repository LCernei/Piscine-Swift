//
//  SecondViewController.swift
//  D03
//
//  Created by LLCereni on 4/25/17.
//  Copyright © 2017 Liviu CERNEI. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIScrollViewDelegate {
    
    var prevPhoto: UIImage = UIImage()
    var imageView: UIImageView?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Single image"
        imageView = UIImageView(image: prevPhoto)
        scrollView.addSubview(imageView!)
        scrollView.contentSize = (imageView?.frame.size)!
        imageView?.contentMode = UIViewContentMode.scaleToFill
        updateZoom()
    }
    
    override func viewDidLayoutSubviews() {
        updateZoom()
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {  return imageView  }
    
    func updateZoom() {
        let imageViewSize = imageView!.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.maximumZoomScale = 1000
    }
}
