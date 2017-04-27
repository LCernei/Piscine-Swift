//
//  ViewController.swift
//  D02
//
//  Created by LLCereni on 4/25/17.
//  Copyright © 2017 Liviu CERNEI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func unWindSegue(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    var data: [RowInfo] = [RowInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Death Note"
        self.tableView.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "stone.jpg")!)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {  return UITableViewAutomaticDimension  }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {  return UITableViewAutomaticDimension  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = data[indexPath.section].name
        cell.descriptionLabel.text = data[indexPath.section].description
        cell.dateLabel.text = data[indexPath.section].date
        
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {  return 25  }
    
    func numberOfSections(in tableView: UITableView) -> Int {  return self.data.count  }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  return 1  }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

