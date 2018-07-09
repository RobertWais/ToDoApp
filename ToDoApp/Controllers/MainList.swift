//
//  MainList.swift
//  ToDoApp
//
//  Created by Robert Wais on 7/5/18.
//  Copyright © 2018 Robert Wais. All rights reserved.
//

import UIKit

class MainList: UITableViewController {

    
    var list = [Todo]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    var completed = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var both = CoreDataHelper.retrieveToDos()
        self.list = both.0
        self.completed = both.1
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0 :
            return list.count
        case 1 :
            return completed.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0 :
                return "Current"
            case 1 :
                return "Completed"
            default :
                return "error"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        //[indexPath.section][indexPath.row]
        var toDo: Todo
        switch indexPath.section {
            case 0 :
                toDo = list[indexPath.row]
            case 1 :
                toDo = completed[indexPath.row]
            default :
                toDo = list[indexPath.row]
        }
        
        cell.titleLbl.text = toDo.name
        cell.postedLbl.text = toDo.timeCreated?.convertToString()
        cell.onButtonTapped = { (cell,delete) in
            guard let indexPath = tableView.indexPath(for: cell) else{
                return
            }
            if delete {
                CoreDataHelper.delete(toDo: toDo)
                var both = CoreDataHelper.retrieveToDos()
                self.list = both.0
                self.completed = both.1
                tableView.reloadData()
            } 
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
 
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue){
        var both = CoreDataHelper.retrieveToDos()
        self.list = both.0
        self.completed = both.1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "presentEdit" :
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            
            var toDo: Todo
            switch indexPath.section {
                case  0 :
                    toDo = list[indexPath.row]
                case 1 :
                    toDo = completed[indexPath.row]
            default :
                    toDo = list[indexPath.row]
            }
            
            let destination = segue.destination as! Details
            destination.toDo = toDo
            
        default :
            print("other")
        }
    }
   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
