//
//  Details.swift
//  ToDoApp
//
//  Created by Robert Wais on 7/6/18.
//  Copyright © 2018 Robert Wais. All rights reserved.
//

import UIKit

class Details: UIViewController {

    var toDo: Todo?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var toBeCompletedTextField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        
        
        //Checks to see if were in edit more or delete mode
        if let toDo = toDo {
            titleTextField.text = toDo.name
            toBeCompletedTextField.text = toDo.timeCreated?.convertToString()
            textView.text = toDo.descriptions
        }else{
            titleTextField.text = ""
            toBeCompletedTextField.text = ""
            textView.text = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard let identifier = segue.identifier else{
            return
        }
        guard let destination = segue.destination as? MainList else{
            return
        }
        
        switch identifier {
        
        case "save" where toDo != nil :
            print("Already object")
            toDo?.name = titleTextField.text ?? ""
            toDo?.timeCreated = Date()
            toDo?.descriptions = textView.text ?? ""
            
            destination.tableView.reloadData()
            
        case "save" where toDo == nil :
            
            print("new object")
            let item = CoreDataHelper.newToDo()
            item.name = titleTextField.text ?? ""
            item.descriptions = textView.text ?? ""
            item.completed = false
            item.timeCreated = Date()
            CoreDataHelper.saveToDo()
        case "cancel" :
            print("Canceled")
        default:
            print("other")
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
