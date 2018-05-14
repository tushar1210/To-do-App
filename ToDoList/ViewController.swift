//
//  ViewController.swift
//  ToDoList
//
//  Created by Tushar Singh on 12/05/18.
//  Copyright © 2018 Tushar Singh. All rights reserved.
//

import UIKit
import RealmSwift

var todos:Results<ToDo>!
var realm = try!Realm()
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var todoTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)as!ToDoCell
        let todo = todos[indexPath.row]
        cell.todoText.text = todo.ToDoText
        cell.isDoneText.text = todo.IsDone ? "It is Done" : "Do it"
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CellClick"{
            var destination = segue.destination as! InsertViewController
            let todo = todos[todoTableView.indexPathForSelectedRow!.row]
            destination.incomingTodo = todo
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = realm.objects(ToDo.self)
        todoTableView.dataSource = self
        todoTableView.delegate = self
        relod()
    }
    override func viewWillAppear(_ animated:Bool) {
        relod()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func relod(){
        todoTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete  {
            try!  realm.write {
                realm.delete(todos[indexPath.row])
            }
            relod()
        }
    }


}

class ToDoCell :  UITableViewCell{
    
    @IBOutlet weak var todoText: UILabel!
    @IBOutlet weak var isDoneText: UILabel!
    

}

class ToDo : Object{
    @objc dynamic var ToDoText=""
    @objc dynamic var IsDone = false

}







