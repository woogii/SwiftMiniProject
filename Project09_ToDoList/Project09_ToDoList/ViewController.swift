//
//  ViewController.swift
//  Project09_ToDoList
//
//  Created by siwook on 2017. 5. 5..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  let setNotificationVCId = "SetNotificationVC"
  var toDoList = [ToDoItem]()
  let stack = CoreDataStack(modelName: "Project09_ToDoList")!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  
    fetchToDoList()
  }
  
  func fetchToDoList() {
   
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"ToDoItem")
  
    do {
      toDoList = try stack.context.fetch(fetchRequest) as! [ToDoItem]
      print(toDoList)
      if toDoList.count > 0 {
        tableView.reloadData()
      }
    } catch {
      fatalError("Could not fetch..\(error)")
    }
  }
  
  @IBAction func tappedAddList(_ sender: UIBarButtonItem) {
  
    let alertController = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
    

    let okAction = UIAlertAction(title: "save", style: .default, handler: { (action)->Void in
      
      guard let textField = alertController.textFields?.first, let item = textField.text else {
        return
      }
      
      let enteredItem = ToDoItem(title: item, context: self.stack.context)
      self.toDoList.append(enteredItem)
      
      do {
        try self.stack.context.save()
      } catch {
        fatalError("cannot save managed objects")
      }
      
      
      DispatchQueue.main.async {
        
        self.tableView.reloadData()
      }
    })
    
    alertController.addTextField(configurationHandler: { (textField:UITextField) -> Void in
      
      textField.placeholder = "Enter the item"
    })
    
    alertController.addAction(okAction)
    
    let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    
    self.present(alertController, animated: true, completion: nil)
    
  }
  
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toDoList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = toDoList[indexPath.row].title ?? ""
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let destinationVC = storyboard.instantiateViewController(withIdentifier: setNotificationVCId) 
    
    navigationController?.pushViewController(destinationVC, animated: true)
  }
}

