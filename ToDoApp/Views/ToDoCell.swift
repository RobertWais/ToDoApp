//
//  ToDoCell.swift
//  ToDoApp
//
//  Created by Robert Wais on 7/6/18.
//  Copyright © 2018 Robert Wais. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {
    
    var onButtonTapped: ((UITableViewCell,Bool) -> Void)? = nil
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var postedLbl: UILabel!
    @IBOutlet weak var doneBox: UIButton!
    
    @IBAction func onCheckedDone(_ sender: Any){
        print("Happened: \(doneBox.isSelected)")
        var completeDelete = false
        
        if doneBox.isSelected {
            completeDelete = true
        }else{
            doneBox.setTitle("Delete",for: .selected)
        }
        doneBox.isSelected = !doneBox.isSelected
        onButtonTapped?(self,completeDelete)
    }
}
