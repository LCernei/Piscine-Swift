//
//  ViewController.swift
//  D00
//
//  Created by lcernei on 4/22/17.
//  Copyright © 2017 Liviu CERNEI. All rights reserved.
//

import UIKit

enum Orientation {
    case horizontal
    case vertical
}

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var buttonsCollection: UICollectionView!
    
    var statement: String = ""
    var result: String = "0"
    var operation: String = ""
    var newNr: String = ""
    var hasOp: Bool = false
    var has1stNr: Bool = false
    var hasEqual: Bool = false
    
    
    var data: [String] = ["AC", "neg", "=", "/",
                          "1", "2", "3", "*",
                          "4", "5", "6", "-",
                          "7", "8", "9", "+",
                          "", "0", "", "%"]
    
    var oriented: Orientation = .vertical
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Style.lightGreen
        buttonsCollection.backgroundColor = Style.lightGreen
        resultLabel.text = "0"
        configureButtons()
    }
    
    private func configureButtons() {
        buttonsCollection.dataSource = self
        buttonsCollection.delegate = self
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if size.height > size.width {
            oriented = .vertical
            data = ["AC", "neg", "=", "/",
                    "1", "2", "3", "*",
                    "4", "5", "6", "-",
                    "7", "8", "9", "+",
                    "", "0", "", "%"]
        }
        else {
            oriented = .horizontal
            data = ["1", "2", "3", "=", "neg", "AC",
                    "4", "5", "6", "+", "-", "/",
                    "7", "8", "9", "0", "*", "%"]
        }
        buttonsCollection.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "button", for: indexPath) as! ButtonCell
        cell.configure(text: data[indexPath.item])
        
        resultLabel.layer.borderWidth = 1
        resultLabel.layer.borderColor = UIColor.black.cgColor
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        
        if oriented == .vertical {
            switch indexPath.item {
            case 0...3, 7, 11, 15, 19:
                cell.defaultColor = Style.orange
            case 16, 18:
                cell.defaultColor = Style.lightGreen
                cell.borderColor = Style.lightGreen
            default:
                cell.defaultColor = UIColor.white
            }
        }
        else {
            switch indexPath.item {
            case 3...5, 9, 10, 11, 16, 17:
                cell.defaultColor = Style.orange
            default:
                cell.defaultColor = UIColor.white
            }
        }
        
        return cell
    }
}

extension String  {
    var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func reset() {
        result = "0"
        operation = ""
        hasOp = false
        has1stNr = false
        statement = ""
        hasEqual = false
    }
    
    func calculate(exp: String) -> String {
        if exp == "NaN" {
            return "NaN"
        }
        var arr = exp.components(separatedBy: ["(", ")"])
        if arr.count != 5 {
            arr.append(arr[0])
            arr.append("*")
            arr.append("1")
            arr[2] = "*"
            arr[3] = "1"
        }
        guard let n1 = Int(arr[1])
            else {
                return "Overflow"
        }
        guard let n2 = Int(arr[3])
            else {
                return "Overflow"
        }
        let op: String = arr[2]
        
        switch op {
        case "+":
            let r = Int.addWithOverflow(n1, n2)
            return r.overflow ? "Overflow" : "\(r.0)"
        case "-":
            let r = Int.subtractWithOverflow(n1, n2)
            return r.overflow ? "Overflow" : "\(r.0)"
        case "*":
            let r = Int.multiplyWithOverflow(n1, n2)
            return r.overflow ? "Overflow" : "\(r.0)"
        case "/":
            if n2 == 0 {
                return "NaN"
            }
            let r = Int.divideWithOverflow(n1, n2)
            return r.overflow ? "Overflow" : "\(r.0)"
        case "%":
            if n2 == 0 {
                return "NaN"
            }
            let r = Int.remainderWithOverflow(n1, n2)
            return r.overflow ? "Overflow" : "\(r.0)"
        default:
            break
        }
        return "Error"
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let char = data[indexPath.item]
        if char == "" {
            return
        }
        collectionView.indexPathsForSelectedItems?.forEach({ (index) in
            if let cell = collectionView.cellForItem(at: index) as? ButtonCell {
                cell.flash()
            }
        })
        print("Button \(char)\twas pressed")
        switch char {
        case "0"..."9":
            if hasOp && !has1stNr {
                statement = "(" + result + ")" + operation
                result = ""
                has1stNr = true
            }
            if hasEqual {
                reset()
            }
            if result == "0" {
                result = ""
            }
            result += char
        case "+", "-", "/", "*", "%":
            if hasOp {
                statement += "(" + result + ")"
                newNr = calculate(exp: statement)
                reset()
                result = newNr
                if result == "Overflow" || result == "NaN" {
                    break
                }
            }
            operation = char
            hasOp = true
            hasEqual = false
        case "AC":
            reset()
        case "neg":
            result = calculate(exp: "(-1)*(" + result + ")")
            if result == "Overflow" || result == "NaN" {
                break
            }
        case "=":
            if hasOp {
                statement += "(" + result + ")"
            }
            if statement == "" {
                statement = result
            }
            newNr = calculate(exp: statement)
            reset()
            result = newNr
            if result == "Overflow" || result == "NaN" {
                break
            }
            hasEqual = true
        default:
            break
        }
        result = calculate(exp: result)
        resultLabel.text = result
        if result == "Overflow" || result == "NaN" {
            reset()
        }
        if !(result.isNumber || result.substring(from: result.index(after: result.startIndex)).isNumber) {
            result = "0"
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bSize = collectionView.frame
        let columnNumber = oriented == .vertical ? 4 : 6
        let itemSize = CGSize(width: Double(bSize.width) / Double( columnNumber ) - 10, height: 50)
        return itemSize
    }
    
}
