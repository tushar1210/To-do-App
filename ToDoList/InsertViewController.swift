//
//  InsertViewController.swift
//  ToDoList
//
//  Created by Tushar Singh on 13/05/18.
//  Copyright © 2018 Tushar Singh. All rights reserved.
//

import UIKit
import RealmSwift

class InsertViewController: UIViewController {
    let realm = try! Realm()
    var incomingTodo: ToDo? = nil
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var todoSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let goodToDo = incomingTodo {
            todoTextField.text=goodToDo.ToDoText
            todoSwitch.isOn=goodToDo.IsDone 
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if let goodToDo = incomingTodo{
            try! realm.write {
                 goodToDo.IsDone=todoSwitch.isOn
                goodToDo.ToDoText=todoTextField.text!
                
            }
        }
        else{
            let todo = ToDo()
            todo.ToDoText = todoTextField.text!
            todo.IsDone=todoSwitch.isOn
            try! realm.write {
                realm.add(todo)
            }
        }
          
        navigationController?.popViewController(animated: true)
        
    }
    


}
