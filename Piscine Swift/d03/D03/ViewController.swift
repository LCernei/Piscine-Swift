//
//  ViewController.swift
//  D03
//
//  Created by LLCereni on 4/25/17.
//  Copyright © 2017 Liviu CERNEI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let data = ["https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA21599_hires.jpg",
               "https://apod.nasa.gov/apod/image/1704/blacksea_modis_960.jpg",
               "https://apod.nasa.gov/apod/image/1704/teapotsirds_winfree_960.jpg",
               "https://apod.nasa.gov/apod/image/1704/PIA21445.croplevels.jpg",
               "https://apod.nasa.gov/apod/image/1704/PIA21445.croplevels.jpg",
               "a l"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Collection of images"
        collectionView.backgroundColor = UIColor.clear
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        performSegue(withIdentifier: "imageClick", sender: cell.imageView.image)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var newString: String = self.data[indexPath.row]
        if newString == "" {
            newString = " "
        }
        newString = newString.replacingOccurrences(of: " ", with: "_")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        (UIApplication.shared.delegate as! AppDelegate).setNetworkActivityIndicatorVisible(true)
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            if let url = URL(string: newString) {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async(execute: {
                        cell.imageView.image = UIImage(data: data)
                        cell.activityIndicator.stopAnimating()
                        cell.imageToSave = UIImage(data: data)!
                        cell.isUserInteractionEnabled = true
                    })
                }
                else {
                    DispatchQueue.main.async(execute: {
                        let alertController = UIAlertController(title: "Error", message:
                            "Cannot access \(newString)", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                        cell.activityIndicator.stopAnimating()
                    })
                }
            }
            (UIApplication.shared.delegate as! AppDelegate).setNetworkActivityIndicatorVisible(false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {  return data.count  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageClick" {
            if let vc2 = segue.destination as? SecondViewController {
                vc2.prevPhoto = sender as! UIImage
            }
        }
    }
}
