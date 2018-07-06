//
//  CoreDataHelper.swift
//  ToDoApp
//
//  Created by Robert Wais on 7/6/18.
//  Copyright © 2018 Robert Wais. All rights reserved.
//

import Foundation
import UIKit
import CoreData



struct CoreDataHelper {
    
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    
    static func newToDo() -> Todo {
        let toDo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: context) as! Todo
        return toDo
    }
    
    static func saveToDo(){
        do {
            try context.save()
        } catch let error {
            print("Saving error: \(error.localizedDescription)")
        }
    }
    
    static func delete(toDo: Todo){
        context.delete(toDo)
        saveToDo()
    }
    
    static func retrieveToDos()->[Todo]{
        do{
            let fetchRequest = NSFetchRequest<Todo>(entityName:"Todo")
            var results =  try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Error retrieving: \(error.localizedDescription)")
            return []
        }
    }
    
    
}
