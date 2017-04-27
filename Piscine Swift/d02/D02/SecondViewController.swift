//
//  SecondViewController.swift
//  D02
//
//  Created by LLCereni on 4/25/17.
//  Copyright © 2017 Liviu CERNEI. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBAction func doneButton(_ sender: AnyObject) {

        if nameField.text?.trimmingCharacters(in: CharacterSet.whitespaces) != "" {
            performSegue(withIdentifier: "goBackSegue", sender: self)
        } else {
            let alertController = UIAlertController(title: "Unidentified body", message:
                "Every body should have a name.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New body"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "stone.jpg")!)
        
        nameField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        nameField.layer.borderWidth = 1
        nameField.layer.borderColor = UIColor.black.cgColor
        
        descriptionField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        descriptionField.layer.borderWidth = 1
        descriptionField.layer.borderColor = UIColor.black.cgColor
        
        datePicker.minimumDate = Date()
        datePicker.frame.size.height = 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goBackSegue" {
            if let vc1 = segue.destination as? ViewController {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "EN_eu")
                dateFormatter.dateFormat = "EEE dd MMM yyyy 'at' HH:mm"
                let strDate = dateFormatter.string(from: datePicker.date)
                vc1.data.append(RowInfo(name: nameField.text!, date: strDate, description: descriptionField.text))
            }
        }
    }
}
